FROM golang:alpine AS build-env
WORKDIR $GOPATH/src/github.com/lfbdev/golang-demo-7
COPY . .
RUN apk add git
RUN go get ./... && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app cmd/golang-demo-7/main.go

FROM alpine
WORKDIR /app
COPY --from=build-env /go/src/github.com/lfbdev/golang-demo-7/app /app/
CMD ["./app"]
USER 1000
EXPOSE 8080/tcp
