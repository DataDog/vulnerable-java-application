[
  {
    "essential": true,
    "image": "${app_ecr_url}",
    "name": "main",
    "command": [
      "sh -c \"export INSTANCE_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4); export DD_TRACE_AGENT_URL=http://$INSTANCE_IP:8126; java -javaagent:/app/dd-java-agent.jar -jar /app/spring-boot-application.jar\""
    ],
    "portMappings": [
      {
        "containerPort": 8000,
        "hostPort": 8000,
        "protocol": "tcp"
      }
    ],
    "environment": [
      {
        "name": "DD_TRACE_AGENT_PORT",
        "value": "8126"
      },
      {
        "name": "DD_APPSEC_ENABLED",
        "value": "true"
      },
      {
        "name": "DD_TRACE_SAMPLE_RATE",
        "value": "1"
      },
      {
        "name": "DD_PROFILING_ENABLED",
        "value": "true"
      },
      {
        "name": "DD_LOGS_INJECTION",
        "value": "true"
      },
      {
        "name": "DD_SERVICE",
        "value": "domain-tester-service"
      },
      {
        "name": "DD_VERSION",
        "value": "1.0"
      },
      {
        "name": "DD_ENV",
        "value": "production"
      },
      {
        "name": "DD_CWS_ENABLED",
        "value": "true"
      }
    ]
  }
]