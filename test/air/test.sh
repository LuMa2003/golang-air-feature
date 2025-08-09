#!/bin/bash

# This test file will be executed against an auto-generated devcontainer.json that
# includes the 'air' Feature with no options.
#
# For more information, see: https://github.com/devcontainers/cli/blob/main/docs/features/test.md
#
# This test can be run with the following command:
#
#    devcontainer features test \ 
#                   --features air   \
#                   --remote-user root \
#                   --skip-scenarios   \
#                   --base-image mcr.microsoft.com/devcontainers/base:ubuntu \
#                   /path/to/this/repo

set -e

# Optional: Import test library bundled with the devcontainer CLI
# See https://github.com/devcontainers/cli/blob/HEAD/docs/features/test.md#dev-container-features-test-lib
# Provides the 'check' and 'reportResults' commands.
source dev-container-features-test-lib

# Feature-specific tests
# The 'check' command comes from the dev-container-features-test-lib.

# Test that air is installed and accessible
check "air is installed" air --version

# Test that air command works
check "air help command" air --help

# Test that Go is available (needed for Air to function)
check "go is available" go version

# Test creating a simple Go program and ensure air can process it
mkdir -p /tmp/test-air
cd /tmp/test-air

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
go mod init test-air

# Test air init command
check "air init command" air init

# Verify .air.toml was created
check "air config file created" test -f .air.toml

# Clean up
cd /
rm -rf /tmp/test-air

# Report results
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults