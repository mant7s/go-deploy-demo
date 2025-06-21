FROM golang:1.24.2-alpine AS builder
WORKDIR /app
COPY . .
RUN go mod tidy && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o go-deploy-demo ./cmd/serve

FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/go-deploy-demo .
COPY ./configs ./configs
CMD ["./go-deploy-demo"]