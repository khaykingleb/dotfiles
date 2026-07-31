{ lib, pkgs, ... }:
let
  onePasswordEnvironmentVariables = {
    NETBOX_TOKEN = "op://Employee/NetBox/credential";
    TOGETHER_PROD_API_KEY = "op://Employee/Together Prod/credential";
    TOGETHER_PROD_BASE_URL = "op://Employee/Together Prod/base_url";
    TOGETHER_QA_API_KEY = "op://Employee/Together QA/credential";
    TOGETHER_QA_BASE_URL = "op://Employee/Together QA/base_url";
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
