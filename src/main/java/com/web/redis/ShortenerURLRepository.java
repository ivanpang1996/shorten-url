package com.web.redis;

/**
 * @author Ivanpang
 */
public interface ShortenerURLRepository {
    void save(ShortenURL url);

    String findLongURLBySuffix(String suffix);
}
