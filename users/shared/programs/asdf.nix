# Runtime version manager
{ pkgs, ... }: {
  home.packages = with pkgs; [
    asdf-vm
  ];
  programs.zsh = {
    # NOTE: https://asdf-vm.com/guide/getting-started.html
    initContent = ''
      # >>> ASDF
      . "${pkgs.asdf-vm}/share/asdf-vm/asdf.sh"
      alias python3="$HOME/.asdf/shims/python3"
      alias pip3="$HOME/.asdf/shims/pip3"
      # <<< ASDF
    '';
  };
}
