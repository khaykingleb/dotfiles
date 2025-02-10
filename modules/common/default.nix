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

  nix = {
    settings = {
      # Necessary for using flakes on this system
      experimental-features = "nix-command flakes";
    };
  };
}
