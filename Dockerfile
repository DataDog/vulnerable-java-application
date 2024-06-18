FROM gradle:8.7.0-jdk21 AS builder
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle bootJar --no-daemon


FROM amazoncorretto:21-alpine-jdk
LABEL org.opencontainers.image.source="https://github.com/DataDog/vulnerable-java-application/"
EXPOSE 8080
RUN mkdir /app
WORKDIR /app
COPY --from=builder /home/gradle/src/build/libs/*.jar /app/spring-boot-application.jar

# Install Datadog agent
RUN wget -O dd-java-agent.jar https://github.com/DataDog/dd-trace-java/releases/download/v1.35.0/dd-java-agent.jar && \
    echo "14f6c325679c7f11db6bc3dc7baba98abd005c1865bd9c61a2a8d560f1a65b26  dd-java-agent.jar" > SHA256SUMS && \
    sha256sum -c SHA256SUMS

# Utility
RUN apk add curl wget
RUN mkdir -p /tmp/files && echo "hello" > /tmp/files/hello.txt && echo "world" > /tmp/files/foo.txt

CMD ["java", "-javaagent:/app/dd-java-agent.jar", "-jar", "/app/spring-boot-application.jar"]
