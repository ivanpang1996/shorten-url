package com.web.service;

public class ShortenURLRequest {
    private String url;

    public ShortenURLRequest(String url) {
        this.url = url;
    }

    public ShortenURLRequest() {
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}
