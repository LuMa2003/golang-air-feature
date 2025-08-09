# Air - Live reload for Go apps

Installs [Air](https://github.com/air-verse/air), a live reloading tool for Go development that automatically rebuilds and restarts Go applications when source files change.

## Prerequisites

Air requires Go to be installed. This feature will work in the following scenarios:

1. **Go base images** (e.g., `mcr.microsoft.com/devcontainers/go:1.21`) - Go is already installed
2. **Non-Go base images** - You need to install Go first using the `go` feature

## Example Usage

### With Go base image
```json
{
    "image": "mcr.microsoft.com/devcontainers/go:1.21",
    "features": {
        "ghcr.io/LuMa2003/golang-air-feature/air:1": {}
    }
}
```

### With non-Go base image (recommended)
```json
{
    "image": "ubuntu:latest",
    "features": {
        "ghcr.io/devcontainers/features/go:1": {},
        "ghcr.io/LuMa2003/golang-air-feature/air:1": {}
    }
}
```

### With specific Air version
```json
{
    "image": "mcr.microsoft.com/devcontainers/go:1.21",
    "features": {
        "ghcr.io/LuMa2003/golang-air-feature/air:1": {
            "version": "v1.49.0"
        }
    }
}
```

## Options

| Options Id | Description | Type | Default Value |
|------------|-------------|------|---------------|
| version | Version of Air to install. Use 'latest' for the most recent version. | string | latest |
| installGo | Whether to install Go if not already present (required for Air installation) | boolean | true |

## Usage

Once installed, you can use Air in your Go projects:

1. Navigate to your Go project directory
2. Initialize Air configuration (optional):
   ```bash
   air init
   ```
3. Run Air to start live reloading:
   ```bash
   air
   ```

Air will watch for file changes and automatically rebuild and restart your Go application.

## Configuration

Air can be configured using a `.air.toml` configuration file in your project root. Run `air init` to generate a default configuration file, or create your own based on the [Air documentation](https://github.com/air-verse/air#config).

## Dependencies

**Important**: This feature requires Go to be installed. 

- If you're using a Go base image (like `mcr.microsoft.com/devcontainers/go:1.21`), Go is already available
- If you're using a non-Go base image (like `ubuntu:latest`), you must install the Go feature first:
  ```json
  "features": {
      "ghcr.io/devcontainers/features/go:1": {},
      "ghcr.io/LuMa2003/golang-air-feature/air:1": {}
  }
  ```

The `installGo` option only controls whether this feature attempts to verify Go installation, but it cannot install Go itself. Use the official `go` feature for that purpose.