# dotfiles
This repository contains my personal configuration for NixOS and macOS systems, managed using [Nix Flakes](https://nixos.wiki/wiki/Flakes), [nix-darwin](https://github.com/LnL7/nix-darwin), and [home-manager](https://github.com/nix-community/home-manager).

## Overview

This setup aims to provide a declarative and reproducible environment across different machines. It includes:

-   System-level configurations (`nix-darwin`)
-   User-specific configurations (`home-manager`)
-   Integration with Homebrew (`nix-homebrew`)

## Prerequisites

Ensure Nix is installed with Flakes support enabled. You can use the [Determinate Systems Nix Installer](https://install.determinate.systems/) for a straightforward installation:
```shell
make nix-install
```

Remember to restart your shell after installation.

## Installation & Usage

1.  Clone the repository:
    ```shell
    git clone https://github.com/khaykingleb/dotfiles.git \
        && mkdir -p ~/.config \
        && mv dotfiles ~/.config/dotfiles
    ```

2. Apply the configuration:

    Use the `Makefile` target corresponding to your system hostname (defined in `flake.nix`). For instance,

    ```shell
    make nix-darwin-apply-macbook-pro-m4
    ```
