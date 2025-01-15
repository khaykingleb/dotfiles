{ inputs, ... }: {
  flake = {
    darwinConfigurations = {
      "macbook" = import ./macbook { inherit inputs; };
    };
  };
}
