package com.web;

public class ShortenURLResponse {
    private final String longURL;
    private final String shortenURL;

    public ShortenURLResponse(String longURL, String shortenURL) {
        this.longURL = longURL;
        this.shortenURL = shortenURL;
    }

    public String getLongURL() {
        return longURL;
    }

    public String getShortenURL() {
        return shortenURL;
    }
}
