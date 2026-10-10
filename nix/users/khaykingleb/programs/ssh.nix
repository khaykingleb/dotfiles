{ config, ... }:
{
  programs.ssh.settings."github.com" = {
    IdentityFile = "${config.home.homeDirectory}/.ssh/id_ed25519";
    IdentitiesOnly = true;
    AddKeysToAgent = "yes";
    UseKeychain = "yes";
  };
}
