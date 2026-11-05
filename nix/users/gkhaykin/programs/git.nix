{ ... }:
{
  # GitHub marks commits "Unverified" unless this key is also added as a Signing
  # Key under GitHub > Settings > SSH and GPG keys.
  programs.git.signing = {
    key = "key::ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ2upzI+VMaN/D62ujbrXEeEzyyc8WA+165bkAcKHXuT";
    signer = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
  };
}
