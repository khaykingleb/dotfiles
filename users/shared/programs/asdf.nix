# Runtime version manager
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    asdf-vm
  ];
  programs.zsh = {
    # NOTE: https://asdf-vm.com/guide/getting-started.html
    initContent = ''
      # >>> ASDF
      . "${pkgs.asdf-vm}/share/asdf-vm/asdf.sh"
      export PATH="$HOME/.asdf/shims:$PATH"
      # <<< ASDF
    '';
  };
}
