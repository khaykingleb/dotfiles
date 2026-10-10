{ config, ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      # Some networks block port 22. GitHub also serves SSH on port 443 at ssh.github.com.
      "github.com *.github.com" = {
        HostName = "ssh.github.com";
        Port = 443;
        User = "git";
        IdentityFile = "${config.home.homeDirectory}/.ssh/id_ed25519";
        IdentitiesOnly = true;
        AddKeysToAgent = "yes";
        UseKeychain = "yes";
      };
    };
  };
}
