# Air - Live reload for Go apps

Installs [Air](https://github.com/air-verse/air), a live reloading tool for Go development that automatically rebuilds and restarts Go applications when source files change.

## Example Usage

```json
"features": {
    "ghcr.io/LuMa2003/golang-air-feature/air:1": {}
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

This feature depends on Go being installed. If Go is not present, it will be installed automatically when `installGo` is set to `true` (default).