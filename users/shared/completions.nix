{ ... }: {
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
    # >>> ASDF completions
    # https://asdf-vm.com/guide/getting-started-legacy.html
    FPATH="$HOME/.asdf/completions:$FPATH"
    # <<< ASDF completions

    # >>> Docker completions
    # https://docs.docker.com/engine/cli/completion/#zsh
    FPATH="$HOME/.docker/completions:$FPATH"
    autoload -Uz compinit
    compinit
    # <<< Docker completions

    # >>> Terraform completions
    autoload -U +X bashcompinit && bashcompinit
    complete -o nospace -C terraform terraform
    # <<< Terraform completions

    # >>> Kubectl completions
    # https://kubernetes.io/docs/reference/kubectl/generated/kubectl_completion/
    source <(kubectl completion zsh)
    # <<< Kubectl completions

    # >>> uv completions
    # https://docs.astral.sh/uv/cli/completion/
    source <(uv generate-shell-completion zsh)
    # <<< uv completions
  '';
}
