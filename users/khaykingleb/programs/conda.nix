{ config, pkgs, ... }: {
  home.activation.conda =
    if pkgs.stdenv.hostPlatform.isDarwin then ''
      sh ${config.home.homeDirectory}/.config/dotfiles/users/khaykingleb/scripts/conda.sh install_conda_macos_silicon
    '' else ''
      sh ${config.home.homeDirectory}/.config/dotfiles/users/khaykingleb/scripts/conda.sh install_conda_linux
    '';
  programs.zsh.initExtra = ''
    # <<< Conda initialization >>>
    __conda_setup="$(${config.home.homeDirectory}/anaconda3/bin/conda 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "${config.home.homeDirectory}/anaconda3/etc/profile.d/conda.sh" ]; then
            . "${config.home.homeDirectory}/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="${config.home.homeDirectory}/anaconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup

    # Force deactivation of base environment for conda
    # (otherwise, it's activated in Cursor IDE for some reason)
    conda deactivate

    # <<< Conda initialization >>>
  '';
}
