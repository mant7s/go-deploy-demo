package main

import (
	"errors"
	"fmt"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"
)

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("/healthz", func(w http.ResponseWriter, r *http.Request) {
		_, err := fmt.Fprintln(w, "ok")
		if err != nil {
			return
		}
	})
	server := &http.Server{
		Addr:    ":8090",
		Handler: mux,
	}

	// 优雅关停
	go func() {
		c := make(chan os.Signal, 1)
		signal.Notify(c, syscall.SIGINT, syscall.SIGTERM)
		<-c
		log.Println("Shutting down...")
		err := server.Close()
		if err != nil {
			return
		}
	}()

	log.Println("Starting server at :8080")
	if err := server.ListenAndServe(); err != nil && !errors.Is(http.ErrServerClosed, err) {
		log.Fatalf("Server failed: %v", err)
	}
	log.Println("Server stopped")
}
