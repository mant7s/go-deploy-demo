#!/bin/bash

go mod tidy

make build

make run

make docker

docker run -p 8090:8090 go-deploy-demo:latest