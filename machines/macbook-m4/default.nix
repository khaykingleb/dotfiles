{ inputs, ... }:
inputs.nix-darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  specialArgs = { inherit inputs; };
  modules = [
    ../../system/darwin

    inputs.home-manager.darwinModules.home-manager # module that integrates home-manager with nix-darwin
    ../../user
  ];
}
