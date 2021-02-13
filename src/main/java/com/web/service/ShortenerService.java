package com.web.service;

import com.web.redis.ShortenURL;
import com.web.redis.ShortenerURLRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author Ivanpang
 */
@Service
public class ShortenerService {
    @Autowired
    ShortenerURLRepository shortenerURLRepository;


    public ShortenURLResponse save(ShortenURLRequest request) {
        String suffix = "hiuh";
        shortenerURLRepository.save(new ShortenURL(request.getUrl(), suffix));

        return new ShortenURLResponse(request.getUrl(), "https://fff.com/" + suffix);
    }

    public String get(String suffix) {
        return shortenerURLRepository.findLongURLBySuffix(suffix);
    }
}
