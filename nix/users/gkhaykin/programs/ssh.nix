{ config, lib, ... }:
let
  onePasswordAgentSocket = "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
in
{
  programs.ssh.settings = {
    # SSH keys live only in 1Password, so SSH fails for every host while the
    # 1Password SSH agent is off. The quotes are part of the value because the
    # path has a space.
    "*".IdentityAgent = ''"${onePasswordAgentSocket}"'';
    "*.cloud.together.ai".User = "gkhaykin";
  };

  # Only the 1Password app can turn the agent on, so warn when the agent is off.
  home.activation.checkOnePasswordSshAgent = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [[ ! -S ${lib.escapeShellArg onePasswordAgentSocket} ]]; then
      echo "warning: the 1Password SSH agent is off, so SSH fails for every host. Turn it on in 1Password > Settings > Developer." >&2
    fi
  '';
}
