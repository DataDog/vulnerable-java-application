# Vulnerable Java application

This repository contains a sample application, the "Websites Tester Service", that's vulnerable to a [Command Injection](https://owasp.org/www-community/attacks/Command_Injection) and [Server-Side Request Forgery (SSRF)](https://owasp.org/Top10/A10_2021-Server-Side_Request_Forgery_%28SSRF%29/) vulnerability.

> **Warning**
> This application is purposely vulnerable and can trivially be hacked. Don't expose it to the Internet, and don't run it in a production environment.
> Instead, you can run it locally on your machine, or in a cloud environment on a private VPC.

## Running locally

1. Build the image locally, or use `ghcr.io/datadog/vulnerable-java-application`:
2. Run:

```
docker run --rm -p 8000:8000 ghcr.io/datadog/vulnerable-java-application
```

3. You can then access the web application at http://127.0.0.1:8000

## Running on Kubernetes

```
kubectl run  vulnerable-application --port=8000 --expose=true --image ghcr.io/datadog/vulnerable-java-application
kubectl port-forward pod/vulnerable-application 8000
```

You can then access the web application at http://127.0.0.1:8000

## Exploitation

### Server-side request vulnerability

1. Browse to http://127.0.0.1:8000/website.html
2. Note how the input allows you to specify arbitrary URLs such as `http://google.com`, but also any internal IP such as `http://169.254.169.254/latest/meta-data/`
3. When the applications is running in AWS, Azure or GCP, this can often be exploited to retrieve instance metadata credentials

### Command injection vulnerability

1. Browse to http://127.0.0.1:8000/index.html
2. Note how the input allows you to specify domain names such as `google.com` and ping them
3. Note that there is some level of input validation - entering `$(whoami)` returns `Invalid domain name: $(whoami) - don't try to hack us!`
4. However, the validation is buggy - notice how you can start the input with a domain name, and execute and command in the container!

### Local file read vulnerability

1. Browse to http://127.0.0.1:8000/file.html
2. Note how the input allows you to specify file names such as `/tmp/files/hello.txt` and read them
3. Note that there is some level of input validation - entering `/etc/passwd` returns `You are not allowed to read /etc/passwd`
4. However, the validation is buggy and vulnerable to path traversal. For instance, you can enter `/tmp/files/../../etc/passwd` to bypass the validation and read any file on the local filesystem.

![image](https://user-images.githubusercontent.com/136675/186954376-e3d82d03-7d9e-49b3-a106-6da080980dae.png)
