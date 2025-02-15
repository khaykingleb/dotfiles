{ ... }: {
  # NOTE: https://docs.docker.com/engine/cli/completion/#zsh
  home.activation.docker = ''
    docker_bin="/usr/local/bin/docker"
    if [ ! -d ~/.docker/completions ]; then
      echo "Setting up docker completions"
      mkdir -p ~/.docker/completions
      $docker_bin completion zsh > ~/.docker/completions/_docker
    else
      echo "Docker completions already set up"
    fi
  '';
  programs.zsh.initExtra = ''
    # >>> Docker
    FPATH="$HOME/.docker/completions:$FPATH"
    autoload -Uz compinit
    compinit
    # <<< Docker
  '';
}
