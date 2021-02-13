package com.web.redis;

import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Repository;

import java.time.Duration;

/**
 * @author Ivanpang
 */
@Repository
public class ShortenerURLRepositoryImpl implements ShortenerURLRepository {
    ValueOperations<String, String> valueOperations;
    private RedisTemplate<String, String> redisTemplate;


    public ShortenerURLRepositoryImpl(RedisTemplate<String, String> redisTemplate) {
        this.redisTemplate = redisTemplate;
        this.valueOperations = redisTemplate.opsForValue();
    }

    @Override
    public void save(ShortenURL url) {
        valueOperations.set(url.getShortURL(), url.getLongURL(), Duration.ofMinutes(30));
    }

    @Override
    public String findLongURLBySuffix(String suffix) {
        return valueOperations.get(suffix);
    }
}
