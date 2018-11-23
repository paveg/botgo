ARG GO_VERSION=1.11.2
FROM golang:$GO_VERSION as build

ENV APP_ROOT $GOPATH/src/github.com/paveg/app

WORKDIR $APP_ROOT
COPY Gopkg.* ./
COPY *.go ./
COPY Makefile ./
RUN go get -u github.com/golang/dep/cmd/dep && dep ensure -vendor-only

RUN CGO_ENABLED=0 GOOS=linux make build

# multi-stage build
FROM alpine:latest as final
RUN apk --no-cache add ca-certificates openssl
WORKDIR /root/
COPY --from=build /go/src/github.com/paveg/app/bin .

CMD ["./botgo"]
