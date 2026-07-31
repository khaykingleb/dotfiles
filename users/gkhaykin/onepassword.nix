{ lib, pkgs, ... }:
let
  onePasswordEnvironmentVariables = {
    NETBOX_TOKEN = "op://Employee/NetBox/credential";
  };

  loadOnePasswordEnvironmentVariable = name: reference: ''
    if secret_value="$(${lib.getExe' pkgs._1password-cli "op"} read ${lib.escapeShellArg reference})"; then
      export ${name}="$secret_value"
    else
      print -u2 "warning: unable to load ${name} from 1Password"
    fi
    unset secret_value
  '';
in
{
  home.packages = [ pkgs._1password-cli ];

  programs.zsh.initContent = lib.mkAfter (
    lib.concatStringsSep "\n" (
      lib.mapAttrsToList loadOnePasswordEnvironmentVariable onePasswordEnvironmentVariables
    )
  );
}
