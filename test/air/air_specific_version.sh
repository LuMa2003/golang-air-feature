#!/bin/bash

# Test the air_specific_version scenario
set -e

# Import test library
source dev-container-features-test-lib

# Test that air is installed and accessible
check "air is installed" air --version

# Test that air command works
check "air help command" air --help

# Test that Go is available (needed for Air to function)
check "go is available" go version

# Test air init command
mkdir -p /tmp/test-air-version
cd /tmp/test-air-version

# Create a simple main.go file
cat > main.go << 'EOF'
package main

import "fmt"

func main() {
    fmt.Println("Hello from specific version test!")
}
EOF

# Initialize go module
go mod init test-air-version

# Test air init command
check "air init command" air init

# Verify .air.toml was created
check "air config file created" test -f .air.toml

# Clean up
cd /
rm -rf /tmp/test-air-version

# Report results
reportResults