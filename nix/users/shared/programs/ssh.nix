{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      # Some networks block port 22. GitHub also serves SSH on port 443 at
      # ssh.github.com, so this block always uses port 443.
      "github.com" = {
        HostName = "ssh.github.com";
        Port = 443;
        User = "git";
      };
    };
  };
}
