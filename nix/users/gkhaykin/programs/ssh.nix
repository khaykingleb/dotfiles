{ config, lib, ... }:
let
  onePasswordAgentSocket = "${config.home.homeDirectory}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock";
in
{
  programs.ssh.settings = {
    # Every host gets its key from the 1Password SSH agent, so SSH fails while
    # that agent is off. The inner quotes are needed because the path has a space.
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
