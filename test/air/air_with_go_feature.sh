#!/bin/bash

# Test the air_with_go_feature scenario (Ubuntu base + Go feature + Air feature)
set -e

# Import test library
source dev-container-features-test-lib

# Test that air is installed and accessible
check "air is installed" air --version

# Test that air command works
check "air help command" air --help

# Test that Go is available (should be from Go feature)
check "go is available" go version

# Test creating a Go project and using air
mkdir -p /tmp/test-air-with-go-feature
cd /tmp/test-air-with-go-feature

# Create a simple Go web application
cat > main.go << 'EOF'
package main

import (
    "fmt"
    "log"
    "net/http"
    "os"
)

func main() {
    port := os.Getenv("PORT")
    if port == "" {
        port = "8080"
    }
    
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "Hello from Air with Go feature on Ubuntu base image!")
    })
    
    http.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "OK")
    })
    
    log.Printf("Server starting on :%s", port)
    log.Fatal(http.ListenAndServe(":"+port, nil))
}
EOF

# Initialize go module
go mod init test-air-with-go-feature

# Test air init command
check "air init command" air init

# Verify .air.toml was created
check "air config file created" test -f .air.toml

# Verify the config contains reasonable defaults for a web app
check "air config contains build command" grep -q "go build" .air.toml
check "air config contains main binary" grep -q "./tmp/main" .air.toml

# Test that we can build the project (air would do this automatically)
go build -o ./tmp/main .
check "go project builds successfully" test -f ./tmp/main

# Clean up
cd /
rm -rf /tmp/test-air-with-go-feature

# Report results
reportResults