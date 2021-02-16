//package com.web.repository;
//
//import org.springframework.data.redis.core.RedisTemplate;
//import org.springframework.data.redis.core.ValueOperations;
//import org.springframework.stereotype.Repository;
//
//import java.time.Duration;
//
///**
// * @author Ivanpang
// */
//@Repository
//public class URLRedisRepositoryImpl implements URLRedisRepository {
//    ValueOperations<String, String> valueOperations;
//    private RedisTemplate<String, String> redisTemplate;
//
//
//    public URLRedisRepositoryImpl(RedisTemplate<String, String> redisTemplate) {
//        this.redisTemplate = redisTemplate;
//        this.valueOperations = redisTemplate.opsForValue();
//    }
//
//    @Override
//    public void save(String suffix, String longURL) {
//        valueOperations.set(suffix, longURL, Duration.ofMinutes(30));
//    }
//
//    @Override
//    public String findLongURLBySuffix(String suffix) {
//        return valueOperations.get(suffix);
//    }
//}
