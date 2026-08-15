{ lib, pkgs, ... }:
let
  completionPlugins = [
    "krew"
    "neat"
    "tree"
    "who-can"
  ];

  mkCompletionAdapter =
    plugin:
    pkgs.writeShellScriptBin "kubectl_complete-${plugin}" ''
      exec kubectl ${lib.escapeShellArg plugin} __complete "$@"
    '';
in
{
  # kubectl discovers plugin completers through executables named kubectl_complete-<plugin>.
  home.packages = map mkCompletionAdapter completionPlugins;

  programs.zsh = {
    initContent = ''
      # >>> KREW
      export PATH="''${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
      # <<< KREW
    '';
  };
}
