{ ... }:
{
  imports = [
    ./packages.nix
  ];

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}
