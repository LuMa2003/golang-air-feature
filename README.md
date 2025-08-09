# Dev Container Feature: Air

> This repository provides the Air devcontainer feature for live reloading Go development. Air is a tool that automatically rebuilds and restarts Go applications when source files change.

## Air Feature

This repository contains the `air` Feature that enables live reloading for Go development in devcontainers.

### `air`

The Air feature installs and configures Air for automatic Go application reloading during development.

```jsonc
{
    "image": "mcr.microsoft.com/devcontainers/go:1.23",
    "features": {
        "ghcr.io/LuMa2003/golang-air-feature/air:1": {
            "version": "latest"
        }
    }
}
```

Once installed, you can:

```bash
# Initialize Air configuration
$ air init

# Start live reloading
$ air
```

## Feature Structure

The repository has a `src` folder containing the Air Feature with its `devcontainer-feature.json` and `install.sh` script.

```
├── src
│   └── air
│       ├── devcontainer-feature.json
│       ├── install.sh
│       └── README.md
└── test
    └── air
        ├── test.sh
        ├── scenarios.json
        └── scenario test files
```

### Options

The Air feature supports the following options in `devcontainer-feature.json`:

```jsonc
{
    "version": {
        "type": "string",
        "default": "latest",
        "description": "Version of Air to install. Use 'latest' for the most recent version."
    },
    "installGo": {
        "type": "boolean",
        "default": false,
        "description": "Install Go if not already available. Set to true if using a non-Go base image."
    }
}
```

## Publishing

This Feature is published to GitHub Container Registry (GHCR) and can be referenced as:

```
ghcr.io/LuMa2003/golang-air-feature/air:1
```

The GitHub Action workflow automatically publishes the Feature to GHCR when changes are pushed to the main branch.