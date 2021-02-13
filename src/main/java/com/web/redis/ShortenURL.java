package com.web.redis;

import java.io.Serializable;

/**
 * @author Ivanpang
 */
public class ShortenURL implements Serializable {
    private String longURL;
    private String shortURL;

    public ShortenURL(String longURL, String shortURL) {
        this.longURL = longURL;
        this.shortURL = shortURL;
    }

    public String getLongURL() {
        return longURL;
    }

    public void setLongURL(String longURL) {
        this.longURL = longURL;
    }

    public String getShortURL() {
        return shortURL;
    }

    public void setShortURL(String shortURL) {
        this.shortURL = shortURL;
    }
}
