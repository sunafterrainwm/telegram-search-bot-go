# syntax=docker/dockerfile:1
FROM golang:1.22-bullseye AS builder
WORKDIR /app
COPY . .

RUN apt-get update && \
    apt-get install -y sqlite3 && \
    rm -rf /var/lib/apt/lists/*

RUN rm config.go && cp docker/config.go .
RUN go mod download
RUN go build -o main .
RUN rm -rf docker entity models *.go

ENTRYPOINT [ "/app/entrypoint.sh" ]
