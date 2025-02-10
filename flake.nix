{
  description = "Personal configuration for macOS and NixOS";

  inputs = {
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
  };

  outputs = { self, nix-darwin, home-manager, nixpkgs, ... } @inputs:
    let
      darwinArch = {
        macbook-pro-m1 = {
          system = "aarch64-darwin";
          user = "khaykingleb";
        };
      };
      mkDarwin = name: { system, user }: nix-darwin.lib.darwinSystem {
        inherit system;
        specialArgs = {
          inherit inputs user;
          hostName = name;
        };
        modules = [
          ./hosts/${name}
          home-manager.darwinModules.home-manager # NOTE: integrates home-manager with nix-darwin
        ];
      };
      forAllSystems = f: nixpkgs.lib.genAttrs
        (builtins.attrValues (builtins.mapAttrs (name: value: value.system) darwinArch))
        f;
      mkDevShell = system:
        let pkgs = nixpkgs.legacyPackages.${system}; in {
          default = with pkgs; mkShell {
            nativeBuildInputs = with pkgs; [
              openssl
              gnupg
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
