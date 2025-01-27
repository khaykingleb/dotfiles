{ config, ... }: {
  programs.zsh.initExtra = ''
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
  '';
}
