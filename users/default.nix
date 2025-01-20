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
      backupFileExtension = "home-manager-backup";

      extraSpecialArgs = {
        inherit inputs;
      };

      users = {
        khaykingleb = import ./khaykingleb;
      };
    };
  };
}
