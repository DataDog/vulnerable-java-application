package com.datadoghq.workshops.samplevulnerablejavaapp.exception;

import com.datadoghq.workshops.samplevulnerablejavaapp.exception.DomainTestException;

public class InvalidDomainException extends DomainTestException {
  public InvalidDomainException(String message) {
    super(message);
  }
}
