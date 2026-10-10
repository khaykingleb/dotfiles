{ config, ... }:
{
  # GitHub must have this key as a Signing Key, or it marks commits "Unverified".
  programs.git.signing.key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
}
