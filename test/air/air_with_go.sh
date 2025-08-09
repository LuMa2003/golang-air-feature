#!/bin/bash

# Test the air_with_go scenario (Go base image with installGo=false)
set -e

# Import test library
source dev-container-features-test-lib

# Test that air is installed and accessible
check "air is installed" air --version

# Test that air command works
check "air help command" air --help

# Test that Go is available (should be from base image)
check "go is available" go version

# Test creating a Go project and using air
mkdir -p /tmp/test-air-with-go
cd /tmp/test-air-with-go

# Create a simple Go application
cat > main.go << 'EOF'
package main

import (
    "fmt"
    "log"
    "net/http"
)

func main() {
    http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
        fmt.Fprintf(w, "Hello from Air with Go base image!")
    })
    
    log.Println("Server starting on :8080")
    log.Fatal(http.ListenAndServe(":8080", nil))
}
EOF

# Initialize go module
go mod init test-air-with-go

# Test air init command
check "air init command" air init

# Verify .air.toml was created
check "air config file created" test -f .air.toml

# Verify the config contains reasonable defaults
check "air config contains build command" grep -q "go build" .air.toml

# Clean up
cd /
rm -rf /tmp/test-air-with-go

# Report results
reportResults