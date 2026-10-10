{ ... }:
{
  # GitHub marks commits "Unverified" unless this key is also added as a Signing
  # Key under GitHub > Settings > SSH and GPG keys.
  programs.git.signing = {
    key = "key::ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIBQCyO0LTJINzAfHr/pRPTmbcMQY3JfiRf1ZJrtUSUa";
    signer = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
  };
}
