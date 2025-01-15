{ inputs, ... }: {
  flake = {
    darwinConfigurations = {
      "macbook-m1" = import ./macbook-m1 { inherit inputs; };
      "macbook-m4" = import ./macbook-m4 { inherit inputs; };
    };
  };
}
