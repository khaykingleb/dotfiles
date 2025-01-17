{
  description = "Personal nix-darwin system flake";

  inputs = {
    # Main package supplier
    nixpkgs = {
      type = "github";
      owner = "NixOS";
      repo = "nixpkgs";
      ref = "nixpkgs-unstable";
    };

    # Reduces the boilerplate code for the flake
    # https://github.com/hercules-ci/flake-parts
    flake-parts = {
      type = "github";
      owner = "hercules-ci";
      repo = "flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
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

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    # TODO(khaykingleb): add NixOS support for Linux later
    systems = [
      "aarch64-darwin"
    ];
    imports = [ ./machines ];
  };
}
