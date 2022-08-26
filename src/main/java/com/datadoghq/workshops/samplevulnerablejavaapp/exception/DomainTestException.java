package com.datadoghq.workshops.samplevulnerablejavaapp.exception;

import lombok.experimental.StandardException;

public class DomainTestException extends Exception {
  public DomainTestException(String message) {
    super(message);
  }
}

