# dotfiles

Personal configuration for macOS systems, managed using [Nix flakes](https://nix.dev/concepts/flakes.html), [nix-darwin](https://github.com/nix-darwin/nix-darwin), and [home-manager](https://github.com/nix-community/home-manager).

## Overview

Declarative and reproducible environment across machines:

- System-level configurations via `nix-darwin`
- User-specific configurations via `home-manager`
- Homebrew integration via `nix-homebrew`
- Cursor and Claude Code configurations from shared definitions

## Layout

| Path                | Contents                                        |
| ------------------- | ----------------------------------------------- |
| `flake.nix`         | Inputs and `darwinConfigurations` for each host |
| `nix/modules/`      | System-level configuration and the package set  |
| `nix/hosts/`        | Per-host configuration, keyed by hostname       |
| `nix/users/shared/` | Program configuration shared across users       |
| `nix/users/<name>/` | Per-user overrides                              |
| `terraform/`        | Account-wide Terraform configuration            |
| `just/`             | Repository task modules                         |

## Setup

1. Install Nix using the [Determinate Systems installer](https://install.determinate.systems/):

   ```shell
   curl --proto '=https' --tlsv1.2 -sSf -L \
     https://install.determinate.systems/nix |
     sh -s -- install
   ```

   Restart the shell after installation.

2. Clone the repository:

   ```shell
   git clone https://github.com/khaykingleb/dotfiles.git ~/.config/dotfiles
   cd ~/.config/dotfiles
   ```

3. Bootstrap the configuration for your machine:

   ```shell
   sudo nix run nix-darwin -- switch \
     --flake .#<hostname> \
     --show-trace
   ```

   where `<hostname>` is one of the systems defined in `flake.nix` (e.g. `macbook-pro-m4`).

4. Start a new shell, then install the configured asdf tools and Krew plugins:

   ```shell
   just sync
   ```

5. Install the repository hooks:

   ```shell
   just setup
   ```

The initial activation installs `nh` and the asdf runtime. Subsequent configuration changes use the Just recipes below.

## Usage

```shell
just                                      # list all available commands
just setup                                # install repository hooks
just nix apply <hostname>                 # build, diff, and apply a host
just nix update                           # update all flake inputs
just nix update nixpkgs                   # update selected flake inputs
just nix clean                            # clean old generations, keeping recent rollbacks
just sync                                 # install configured asdf tools and Krew plugins
just terraform                            # list Terraform commands
```

## Uninstall

Remove the Determinate Nix installation explicitly:

```shell
/nix/nix-installer uninstall
```
