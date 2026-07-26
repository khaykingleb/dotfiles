# Handles system-level configuration for Macbook Pro M1 (macOS)
{ ... }:
{
  imports = [ ../../modules/darwin ];

  my.isPersonal = true;

  # networking.hostName = hostName;
}
