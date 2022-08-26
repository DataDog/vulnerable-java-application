#!/bin/bash
set -e

REPO_NAME="domain-tester-service"

if ! aws sts get-caller-identity >/dev/null 2>&2; then
  echo "You are not authenticated to AWS"
fi

aws ecr create-repository --repository-name $REPO_NAME >/dev/null 2>&1 || true
REPO_URL=$(aws ecr describe-repositories --repository-names  domain-tester-service | jq -r '.repositories[0].repositoryUri')
docker tag domain-tester-service $REPO_URL

REGISTRY_URL=$(echo $REPO_URL | cut -d/ -f1)
aws ecr get-login-password | docker login --username AWS --password-stdin $REGISTRY_URL
docker push $REPO_URL
echo $REPO_URL