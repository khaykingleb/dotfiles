{ config, ... }: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*.github.com" = {
        extraOptions = {
          "AddKeysToAgent" = "yes";
          "UseKeychain" = "yes";
        };
        identityFile = "${config.home.homeDirectory}/.ssh/id_ed25519";
      };
      "*.vast.ai" = {
        identityFile = "${config.home.homeDirectory}/.ssh/vastai";
      };
      "red" = {
        hostname = "64.247.196.50";
        user = "shadeform";
        identityFile = "${config.home.homeDirectory}/Desktop/projects/iclerk/gpu-access/shadeform_private_key.pem";
      };
      "alabama alaska" = {
        user = "gkhaykin";
        proxyCommand = "/opt/homebrew/bin/cloudflared access ssh --hostname %h-dc10.myna.ninja/ssh";
      };
      "*.cloud.together.ai" = {
        user = "gkhaykin";
      };
    };
  };
}
