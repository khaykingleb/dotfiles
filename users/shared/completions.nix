{ config, lib, ... }:
let
  completionsDirectory = "${config.home.homeDirectory}/.zsh/completions";

  # Generate completion scripts during activation because invoking each tool
  # from zsh init adds startup latency to every interactive and agent shell.
  completionCommands = [
    "argocd completion zsh"
    "buf completion zsh"
    "docker completion zsh"
    "helm completion zsh"
    "just --completions zsh"
    "kubectl completion zsh"
    "kubie generate-completion zsh"
    "pnpm completion zsh"
    "supabase completion zsh"
    "uv generate-shell-completion zsh"
  ];
in
{
  # Regenerate rather than reuse cached files because asdf upgrades can change
  # command interfaces and their completions.
  home.activation.generateZshCompletions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    (
      # asdf shims and Docker Desktop live outside the Nix activation's PATH.
      PATH="$HOME/.asdf/shims:/usr/local/bin:$PATH"

      generate_zsh_completion() {
        local file="_$1"
        local errors
        command -v "$1" >/dev/null 2>&1 || return 0
        if [[ -v DRY_RUN ]]; then
          verboseEcho "Would generate ${completionsDirectory}/$file"
        elif ! errors=$("$@" 2>&1 > ${lib.escapeShellArg completionsDirectory}/"$file"); then
          rm -f ${lib.escapeShellArg completionsDirectory}/"$file"
          echo "warning: failed to generate zsh completion $file: $errors" >&2
        fi
      }

      run mkdir -p ${lib.escapeShellArg completionsDirectory}
      ${lib.concatStringsSep "\n      " (
        map (command: "generate_zsh_completion ${command}") completionCommands
      )}
    )
  '';

  programs.zsh.initContent = ''
    # >>> Generated completions
    FPATH="${completionsDirectory}:$FPATH"
    # <<< Generated completions

    autoload -Uz compinit
    compinit

    # <<< Bash-style completers
    # These tools expose Bash-compatible external completers rather than native
    # zsh completion functions.
    autoload -U +X bashcompinit && bashcompinit
    (( $+commands[terraform] )) && complete -o nospace -C terraform terraform
    (( $+commands[tofu] )) && complete -o nospace -C tofu tofu
    (( $+commands[aws_completer] )) && complete -C aws_completer aws
    # <<< Bash-style completers
  '';
}
