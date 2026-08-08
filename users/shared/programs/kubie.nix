{
  config,
  lib,
  pkgs,
  ...
}:
let
  completionsDirectory = "${config.home.homeDirectory}/.zsh/completions";
  kubieCompletion = "${completionsDirectory}/_kubie";
in
{
  # TODO: Remove when Kubie supports dynamic context completion.
  # https://github.com/kubie-org/kubie/pull/374
  home.file.".zsh/completions/_kubie_contexts".text = ''
    #autoload
    local -a contexts
    contexts=("''${(@f)$(kubie ctx 2>/dev/null)}")
    _describe "Kubie context" contexts
  '';

  home.activation.patchKubieContextCompletion = lib.hm.dag.entryAfter [ "generateZshCompletions" ] ''
    kubie_completion=${lib.escapeShellArg kubieCompletion}
    if [[ -v DRY_RUN ]]; then
      verboseEcho "Would add dynamic context completion to $kubie_completion"
    elif [[ -f "$kubie_completion" ]]; then
      ${lib.getExe' pkgs.gnused "sed"} -i \
        "/Name of the context to enter/ s/:_default'/:_kubie_contexts'/" \
        "$kubie_completion"
      if [[ "$(<"$kubie_completion")" != *":_kubie_contexts'"* ]]; then
        echo "warning: failed to add Kubie context completion" >&2
      fi
    fi
  '';
}
