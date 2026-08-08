# Handles system-level configuration for Macbook Pro M4 for personal use (macOS)
{ ... }:
{
  imports = [ ../../modules/darwin ];

  my.isPersonal = true;

  # networking.hostName = hostName;
}
