package com.web.service;

import com.web.repository.URLRedisRepository;
import com.web.repository.URLRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.retry.annotation.Backoff;
import org.springframework.retry.annotation.Retryable;
import org.springframework.stereotype.Service;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.UUID;

/**
 * @author Ivanpang
 */
@Service
public class ShortenerService {
    @Autowired
    URLRedisRepository redisRepository;
    @Autowired
    URLRepository repository;

    @Retryable(value = SQLIntegrityConstraintViolationException.class, maxAttempts = 10, backoff = @Backoff(3000))  //retry 10 times when duplicate entry
    public ShortenURLResponse save(ShortenURLRequest request) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("MD5");
        String suffix = generateSuffix(request.getUrl(), md);
        repository.insert(suffix, request.getUrl());
        return new ShortenURLResponse(request.getUrl(), "http://url-shortener-lb-1711713777.us-east-1.elb.amazonaws.com/" + suffix);
    }

    public String get(String suffix) {
        String url = redisRepository.findLongURLBySuffix(suffix);
        if (url != null) return url;

        String longURL = repository.findById(suffix).orElseThrow().longUrl;
        redisRepository.save(suffix, longURL);
        return longURL;
    }

    private String generateSuffix(String originalURL, MessageDigest md) {
        originalURL += UUID.randomUUID().toString();
        md.update(originalURL.getBytes());
        byte[] digest = md.digest();
        StringBuilder sb = new StringBuilder();
        for (byte b : digest) {
            sb.append(Integer.toHexString(b & 0xff));
        }
        return sb.substring(0, 6);
    }
}
