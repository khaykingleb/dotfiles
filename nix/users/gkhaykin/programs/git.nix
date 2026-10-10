{ ... }:
{
  # GitHub must have this key as a Signing Key, or it marks commits "Unverified".
  programs.git.signing = {
    key = "key::ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIBQCyO0LTJINzAfHr/pRPTmbcMQY3JfiRf1ZJrtUSUa";
    signer = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
  };
}
