FROM golang:1.14 as build

WORKDIR /go/src/app
ADD . /go/src/app
ENV GO111MODULE=on
RUN go get -d -v ./...
RUN go build -o /go/bin/app main.go

FROM gcr.io/distroless/base-debian10
COPY --from=build /go/bin/app /
ENTRYPOINT ["/app"]
