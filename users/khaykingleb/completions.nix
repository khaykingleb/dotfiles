{ ... }: {
  # NOTE:
  # * https://docs.docker.com/engine/cli/completion/#zsh
  # * https://kubernetes.io/docs/reference/kubectl/generated/kubectl_completion/
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
    # >>> Docker completions
    FPATH="$HOME/.docker/completions:$FPATH"
    autoload -Uz compinit
    compinit
    # <<< Docker completions

    # >>> Kubectl completions
    source <(kubectl completion zsh)
    # <<< Kubectl completions
  '';
}
