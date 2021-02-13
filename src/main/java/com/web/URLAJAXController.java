package com.web;

import com.web.service.ShortenURLRequest;
import com.web.service.ShortenURLResponse;
import com.web.service.ShortenerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.view.RedirectView;

@RestController
public class URLAJAXController {
    @Autowired
    ShortenerService shortenerService;

    @GetMapping(path = "/")
    public @ResponseBody byte[] healthCheck() {
        return new byte[1];
    }

    @PostMapping(path = "/newurl")
    public ShortenURLResponse url(@RequestBody ShortenURLRequest request) {
        return shortenerService.save(request);
    }

    @GetMapping(path = "/{suffix}")
    public RedirectView get(@PathVariable("suffix") String suffix) {
        String result = shortenerService.get(suffix);
        if (result == null) return redirectView("http://www.youtube.com");
        return redirectView(result);
    }

    private RedirectView redirectView(String url) {
        RedirectView redirectView = new RedirectView();
        redirectView.setUrl(url);
        return redirectView;
    }
}
