# Runtime version manager
{ pkgs, ... }: {
  home.packages = with pkgs; [
    asdf-vm
  ];
  programs.zsh = {
    # NOTE: https://asdf-vm.com/guide/getting-started.html
    initExtra = ''
      # <<< ASDF initialization >>>
      . "${pkgs.asdf-vm}/share/asdf-vm/asdf.sh"
      . "${pkgs.asdf-vm}/share/asdf-vm/completions/asdf.bash"
      # <<< ASDF initialization >>>
    '';
  };
}
