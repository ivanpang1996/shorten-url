package com.web;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.view.RedirectView;

@RestController
public class URLAJAXController {
    @GetMapping(path = "/")
    public @ResponseBody byte[] healthCheck() {
        return new byte[1];
    }

    @PostMapping(path = "/newurl")
    public ShortenURLResponse url(@RequestParam("url") String url) {
        return new ShortenURLResponse("google.com", "short.com");
    }

    @GetMapping(path = "/{suffix}")
    public RedirectView get(@PathVariable("suffix") String suffix) {
        RedirectView redirectView = new RedirectView();
        redirectView.setUrl("http://www.youtube.com");
        return redirectView;
    }
}
