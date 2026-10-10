{ config, ... }:
{
  # GitHub marks commits "Unverified" unless this key is also added as a Signing
  # Key under GitHub > Settings > SSH and GPG keys.
  programs.git.signing.key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
}
