#!/bin/bash

# Test the air_default scenario - should work with Go installation
set -e

# Import test library
source dev-container-features-test-lib

# Test that air is installed and accessible
check "air is installed" air --version

# Test that air command works
check "air help command" air --help

# Test that Go is available (needed for Air to function)
check "go is available" go version

# Test creating a simple Go program and ensure air can process it
mkdir -p /tmp/test-air-default
cd /tmp/test-air-default

# Create a simple main.go file
cat > main.go << 'EOF'
package main

import (
    "fmt"
    "time"
)

func main() {
    for {
        fmt.Println("Hello from Air test!")
        time.Sleep(2 * time.Second)
    }
}
EOF

# Initialize go module
go mod init test-air-default

# Test air init command
check "air init command" air init

# Verify .air.toml was created
check "air config file created" test -f .air.toml

# Clean up
cd /
rm -rf /tmp/test-air-default

# Report results
reportResults