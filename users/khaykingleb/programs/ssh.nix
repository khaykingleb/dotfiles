{
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*.github.com" = {
        extraOptions = {
          "AddKeysToAgent" = "yes";
          "UseKeychain" = "yes";
        };
        identityFile = "~/.ssh/id_ed25519";
      };

      "*.vast.ai" = {
        identityFile = "~/.ssh/vastai";
      };

      "red" = {
        hostname = "64.247.196.50";
        user = "shadeform";
        identityFile = "~/Users/khaykingleb/projects/iclerk/gpu-access/shadeform_private_key.pem";
      };

      "alabama alaska" = {
        user = "gkhaykin";
        proxyCommand = "/opt/homebrew/bin/cloudflared access ssh --hostname %h-dc10.myna.ninja/ssh";
      };
    };
  };
}
