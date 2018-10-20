.PHONY: build run

BUILD_TAG = develop
IMAGE_NAME = botgo
IMAGE = $(IMAGE_NAME):$(BUILD_TAG)

build:
	docker build -t $(IMAGE) .

run:
	docker run --rm --name $(IMAGE_NAME) -e BOTID -e BOTTOKEN -e CHANNELID -e VERIFICATION_TOKEN $(IMAGE)
