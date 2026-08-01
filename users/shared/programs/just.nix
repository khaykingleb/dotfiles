{ lib, ... }:
{
  programs.zsh.initContent = lib.mkAfter ''
    # >>> Just completions
    if (( $+commands[just] )); then
      source <(just --completions zsh)
    fi
    # <<< Just completions
  '';
}
