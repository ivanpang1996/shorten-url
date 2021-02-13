package com.web;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.view.RedirectView;

@RestController
public class URLAJAXController {
    @GetMapping(path = "/")
    public @ResponseBody
    byte[] healthCheck() {
        return new byte[1];
    }

    @PostMapping(path = "/newurl")
    public ShortenURLResponse url(@RequestBody ShortenURLRequest request) {
        return new ShortenURLResponse("google.com", "short.com");
    }

    @GetMapping(path = "/{suffix}")
    public RedirectView get(@PathVariable("suffix") String suffix) {
        RedirectView redirectView = new RedirectView();
        redirectView.setUrl("http://www.youtube.com");
        return redirectView;
    }
}
