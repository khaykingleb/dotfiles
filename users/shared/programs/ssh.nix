{ config, ... }: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*.cloud.together.ai" = {
        user = "gkhaykin";
      };
      "*.vast.ai" = {
        identityFile = "${config.home.homeDirectory}/.ssh/vastai";
      };
      "alabama alaska" = {
        user = "gkhaykin";
        proxyCommand = "/opt/homebrew/bin/cloudflared access ssh --hostname %h-dc10.myna.ninja/ssh";
      };
      "github.com *.github.com" = {
        hostname = "ssh.github.com";
        port = 443;
        user = "git";
        identityFile = "${config.home.homeDirectory}/.ssh/id_rsa";
        identitiesOnly = true;
        extraOptions = {
          "AddKeysToAgent" = "yes";
          "UseKeychain" = "yes";
        };
      };
      "red" = {
        hostname = "64.247.196.50";
        user = "shadeform";
        identityFile = "${config.home.homeDirectory}/Desktop/projects/iclerk/gpu-access/shadeform_private_key.pem";
      };
    };
  };
}
