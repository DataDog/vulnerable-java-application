package com.datadoghq.workshops.samplevulnerablejavaapp;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.client.RestTemplate;

@Service
public class WebsiteTestService {
    @Autowired
    private RestTemplate rest;

    public String testWebsite(String url) {
        try {
            return this.rest.getForObject(url, String.class);
        } catch (HttpClientErrorException | HttpServerErrorException e) {
            return "URL returned status code: " + e.getStatusCode();
        }
    }
}
