.PHONY: build run get.tools setup dep clean dkr.build dkr.run

APP_NAME = botgo
.DEFAULT_GOAL := bin/$(APP_NAME)
GO_VERSION := 1.11.2 # default go version.
ifeq ($shell ls -a | grep .go-version), .go-version)
	GO_VERSION:= $(shell cat .go-version)
endif
SRCS := $(shell find . -type f -name '*.go')
REVISION := $(shell git rev-parse --short HEAD)
LDFLAGS := -ldflags="-s -w -X \"main.Revision=$(REVISION)\" -extldflags \"-static\""
VERSION_TAG ?= latest
IMAGE_NAME = $(APP_NAME):$(VERSION_TAG)

ifeq ($(.DEFAULT_GOAL),)
	$(warning no default goal)
endif

build: $(SRCS)
	go build -a -tags netgo -installsuffix netgo $(LDFLAGS) -o $(.DEFAULT_GOAL)

run:
	./bin/botgo

setup:
	make get.tools
	make dep

get.tools:
	@if [ ! -z `which dep` ]; then\
		go get -u github.com/golang/dep/cmd/dep;\
	fi

dep:
	dep ensure -v -vendor-only

clean:
	rm -rf bin/*
	rm -rf vendor/*

dkr.build:
	docker build --build-arg GO_VERSION=$(GO_VERSION) -t $(IMAGE_NAME) .

dkr.run:
	docker run -it --rm --name $(APP_NAME) -e BOTID -e BOTTOKEN -e CHANNELID -e VERIFICATION_TOKEN $(IMAGE_NAME)
