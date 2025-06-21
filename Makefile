APP=go-deploy-demo
BIN=bin/$(APP)

.PHONY: build test clean run docker

build:
	go build -o bin/$(APP) ./cmd/$(APP)

test:
	go test ./...

run:
	go run ./cmd/$(APP)

clean:
	rm -rf bin/

docker:
	docker build -t $(APP):latest .