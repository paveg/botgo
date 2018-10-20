ARG GO_VERSION=1.11.0
FROM golang:$GO_VERSION

ENV APP_ROOT $GOPATH/src/app

RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT
ADD Gopkg.* ./
ADD main.go ./
RUN go get -u github.com/golang/dep/cmd/dep && \
    dep ensure -vendor-only

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

# multi-stage build
FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /go/src/app .

CMD ["./app"]
