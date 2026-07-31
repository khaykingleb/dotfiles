{ lib, pkgs, ... }:
let
  onePasswordAccount = "together-ai.1password.com";

  onePasswordEnvironmentVariables = {
    NETBOX_TOKEN = "op://Employee/NetBox/credential";
    TOGETHER_PROD_API_KEY = "op://Employee/Together Prod/credential";
    TOGETHER_PROD_BASE_URL = "op://Employee/Together Prod/base_url";
    TOGETHER_QA_API_KEY = "op://Employee/Together QA/credential";
    TOGETHER_QA_BASE_URL = "op://Employee/Together QA/base_url";
  };

  environmentTemplate = pkgs.writeText "onepassword-environment.tpl" (
    lib.concatStrings (
      lib.mapAttrsToList (name: reference: "${name}={{ ${reference} }}\n") onePasswordEnvironmentVariables
    )
  );
in
{
  home.packages = [ pkgs._1password-cli ];

  # Launching `op` costs ~100ms and happens on every shell startup, so
  # Loads all 1Password environment variables with one op inject call instead
  programs.zsh.initContent = lib.mkAfter ''
    if onepassword_environment="$(${lib.getExe' pkgs._1password-cli "op"} inject --account ${lib.escapeShellArg onePasswordAccount} --in-file ${environmentTemplate})"; then
      # Parsed rather than eval'd so secret values are never run as shell code.
      while IFS='=' read -r name value; do
        [[ -n "$name" ]] && export "$name=$value"
      done <<< "$onepassword_environment"
    else
      print -u2 "warning: unable to load environment from 1Password"
    fi
    unset onepassword_environment name value
  '';
}
