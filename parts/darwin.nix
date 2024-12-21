{ inputs, ... }: {
  flake = {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#khaykingleb-macbook
    darwinConfigurations."khaykingleb-macbook" = inputs.nix-darwin.lib.darwinSystem {
      modules = [
        ../modules/darwin
      ];
    };
  };
}
