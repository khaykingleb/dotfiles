{ config, ... }:
{
  home.sessionPath = [ "${config.home.homeDirectory}/.tcloud/bin" ];
}
