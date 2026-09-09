{ ... }:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 10;
    historyLimit = 100000;
    mouse = true;
    terminal = "tmux-256color";

    extraConfig = ''
      set -as terminal-features ',xterm-256color:RGB'
      set -g renumber-windows on
    '';
  };
}
