# dotfiles

Personal configuration for macOS systems, managed using [Nix Flakes](https://nixos.wiki/wiki/Flakes), [nix-darwin](https://github.com/LnL7/nix-darwin), and [home-manager](https://github.com/nix-community/home-manager).

## Overview

Declarative and reproducible environment across machines:

- System-level configurations via `nix-darwin`
- User-specific configurations via `home-manager`
- Homebrew integration via `nix-homebrew`

## Setup

1. Install Nix using the [Determinate Systems installer](https://install.determinate.systems/):
    ```shell
    just nix-install
    ```

2. Clone the repository:
    ```shell
    git clone https://github.com/khaykingleb/dotfiles.git ~/.config/dotfiles
    cd ~/.config/dotfiles
    ```

3. Apply the configuration for your machine:
    ```shell
    just nix-apply <hostname>
    ```
    where `<hostname>` is one of the systems defined in `flake.nix` (e.g. `macbook-pro-m4`).

## Usage

```shell
just                        # list all available commands
just nix-apply <hostname>   # apply configuration
just nix-update-flake       # update flake inputs
just nix-gc                 # garbage collect unused packages
```
