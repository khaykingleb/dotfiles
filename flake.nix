{
  description = "Declarative system configuration and package management for macOS";

  inputs = {
    # Private configuration with sensitive data
    private-config = {
      url = "git+ssh://git@github.com/khaykingleb/dotfiles-private.git";
      flake = false;
    };

    # Main package supplier
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixpkgs-unstable";
    };

    # Support for MacOS specific features
    # https://github.com/LnL7/nix-darwin
    nix-darwin = {
      type = "github";
      owner = "lnl7";
      repo = "nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Manage userspace with nix
    # https://github.com/nix-community/home-manager
    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Integrates homebrew with nix-darwin
    # https://github.com/zhaofengli/nix-homebrew
    nix-homebrew = {
      # TODO: Return to github:zhaofengli/nix-homebrew after
      # https://github.com/zhaofengli/nix-homebrew/pull/167 is merged.
      type = "github";
      owner = "zhaofengli";
      repo = "nix-homebrew";
      ref = "pull/167/head";
    };

    homebrew-bundle = {
      type = "github";
      owner = "homebrew";
      repo = "homebrew-bundle";
      flake = false;
    };

    homebrew-core = {
      type = "github";
      owner = "homebrew";
      repo = "homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      type = "github";
      owner = "homebrew";
      repo = "homebrew-cask";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      home-manager,
      nix-homebrew,
      homebrew-bundle,
      homebrew-core,
      homebrew-cask,
      ...
    }@inputs:
    let
      darwinArch = {
        macbook-pro-m1 = {
          system = "aarch64-darwin";
          user = "khaykingleb";
        };
        macbook-pro-m4 = {
          system = "aarch64-darwin";
          user = "khaykingleb";
        };
        macbook-pro-m4-together = {
          system = "aarch64-darwin";
          user = "gkhaykin";
        };
      };
      systems = [
        "aarch64-darwin"
        "x86_64-linux"
      ];
      mkDarwin =
        name:
        { system, user }:
        nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = {
            inherit inputs user;
            hostName = name;
          };
          modules = [
            home-manager.darwinModules.home-manager # NOTE: integrates home-manager with nix-darwin
            nix-homebrew.darwinModules.nix-homebrew # NOTE: integrates homebrew with nix-darwin
            {
              nix-homebrew = {
                inherit user;
                enable = true;
                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                  "homebrew/homebrew-bundle" = homebrew-bundle;
                };
                mutableTaps = false;
                autoMigrate = true;
              };
            }
            ./systems/${name}
          ];
        };
      forAllSystems = nixpkgs.lib.genAttrs systems;
      mkDevShell =
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default =
            with pkgs;
            mkShell {
              buildInputs = [
                git
                pre-commit
                openssl
                gnupg
                gnutar
                xz
                zlib
                ncurses
                bzip2
                libffi
                sqlite
              ];
            };
        };
    in
    {
      devShells = forAllSystems mkDevShell;
      darwinConfigurations = builtins.mapAttrs mkDarwin darwinArch;
    };
}
