# Runtime version manager
{ pkgs, ... }: {
  home.packages = with pkgs; [
    asdf-vm
  ];
  programs.zsh = {
    # NOTE: https://asdf-vm.com/guide/getting-started.html
    initExtra = ''
      # >>> ASDF
      . "${pkgs.asdf-vm}/share/asdf-vm/asdf.sh"
      # <<< ASDF
    '';
  };
}
