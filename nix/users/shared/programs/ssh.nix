{ config, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*.cloud.together.ai" = {
        User = "gkhaykin";
      };
      "*.vast.ai" = {
        IdentityFile = "${config.home.homeDirectory}/.ssh/vastai";
      };
      "alabama alaska" = {
        User = "gkhaykin";
        ProxyCommand = "/opt/homebrew/bin/cloudflared access ssh --hostname %h-dc10.myna.ninja/ssh";
      };
      "github.com *.github.com" = {
        HostName = "ssh.github.com";
        Port = 443;
        User = "git";
        IdentityFile = "${config.home.homeDirectory}/.ssh/id_ed25519";
        IdentitiesOnly = true;
        AddKeysToAgent = "yes";
        UseKeychain = "yes";
      };
      "red" = {
        HostName = "64.247.196.50";
        User = "shadeform";
        IdentityFile = "${config.home.homeDirectory}/Desktop/projects/iclerk/gpu-access/shadeform_private_key.pem";
      };
    };
  };
}
