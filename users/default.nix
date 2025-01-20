# User level configuration:
# * Configures user environments
# * Manages user-specific settings
# * Handles dotfiles and user packages
# * Runs with user permissions

{ inputs, ... }:
{
  config = {
    home-manager = {
      verbose = true;
      useGlobalPkgs = true;
      useUserPackages = true;

      extraSpecialArgs = {
        inherit inputs;
      };

      users = {
        khaykingleb = import ./khaykingleb;
      };
    };
  };
}
