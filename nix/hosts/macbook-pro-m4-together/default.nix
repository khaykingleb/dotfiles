# Handles system-level configuration for Macbook Pro M4 for work (macOS)
{ ... }:
{
  imports = [ ../../modules/darwin ];

  my.isPersonal = false;

  # networking.hostName = hostName;
}
