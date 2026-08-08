# dotfiles

Personal configuration for macOS systems, managed using [Nix flakes](https://nix.dev/concepts/flakes.html), [nix-darwin](https://github.com/nix-darwin/nix-darwin), and [home-manager](https://github.com/nix-community/home-manager).

## Overview

Declarative and reproducible environment across machines:

- System-level configurations via `nix-darwin`
- User-specific configurations via `home-manager`
- Homebrew integration via `nix-homebrew`
- Cursor and Claude Code configurations from shared definitions

Agent rules, skills, and MCP servers are defined once in `users/shared/programs/agents`. Nix renders them into the per-client format each tool expects, so Cursor and Claude Code stay in sync.

## Layout

| Path            | Contents                                        |
| --------------- | ----------------------------------------------- |
| `flake.nix`     | Inputs and `darwinConfigurations` for each host |
| `modules/`      | System-level configuration and the package set  |
| `systems/`      | Per-host configuration, keyed by hostname       |
| `users/shared/` | Program configuration shared across users       |
| `users/<name>/` | Per-user overrides                              |

## Setup

1. Install Nix using the [Determinate Systems installer](https://install.determinate.systems/):

   ```shell
   curl --proto '=https' --tlsv1.2 -sSf -L \
     https://install.determinate.systems/nix/tag/v0.32.2 |
     sh -s -- install
   ```

   Restart the shell after installation.

2. Clone the repository:

   ```shell
   git clone https://github.com/khaykingleb/dotfiles.git ~/.config/dotfiles
   cd ~/.config/dotfiles
   ```

3. Apply the configuration for your machine:

   ```shell
   sudo nix run nix-darwin -- switch \
     --flake .#<hostname> \
     --show-trace
   ```

   where `<hostname>` is one of the systems defined in `flake.nix` (e.g. `macbook-pro-m4`).

4. Start a new shell, then install the asdf-managed tools:

   ```shell
   ./users/shared/programs/asdf/install.sh
   ```

   The initial activation installs `nh` and the asdf runtime. Subsequent configuration changes use the Just recipes below.

## Usage

```shell
just                        # list all available commands
just nix-apply <hostname>   # apply configuration
just nix-update-flake       # update flake inputs
just nix-gc                 # garbage collect unused packages
```

## Uninstall

Remove the Determinate Nix installation explicitly:

```shell
/nix/nix-installer uninstall
```
