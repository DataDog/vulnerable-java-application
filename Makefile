.PHONY: all build push

all: build push

build:
	scripts/build-docker.sh

push:
	scripts/push-docker.sh
