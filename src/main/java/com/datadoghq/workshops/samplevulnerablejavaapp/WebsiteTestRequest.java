package com.datadoghq.workshops.samplevulnerablejavaapp;

import lombok.Data;

@Data
public class WebsiteTestRequest {
    String url;
    String customHeaderKey;
    String customHeaderValue;
}
