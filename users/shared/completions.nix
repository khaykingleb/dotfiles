{ ... }: {
  home.activation.docker = ''
    docker_bin="/usr/local/bin/docker"
    if [[ ! -x "$docker_bin" ]]; then
      docker_bin="$(command -v docker || true)"
    fi
    if [[ -z "$docker_bin" ]]; then
      echo "Docker CLI is not available; skipping completions"
    elif [[ ! -f ~/.docker/completions/_docker ]]; then
      echo "Setting up docker completions"
      mkdir -p ~/.docker/completions
      "$docker_bin" completion zsh > ~/.docker/completions/_docker
    else
      echo "Docker completions already set up"
    fi
  '';
  programs.zsh.initContent = ''
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
    if (( $+commands[terraform] )); then
      autoload -U +X bashcompinit && bashcompinit
      complete -o nospace -C terraform terraform
    fi
    # <<< Terraform completions

    # >>> Kubectl completions
    # https://kubernetes.io/docs/reference/kubectl/generated/kubectl_completion/
    if (( $+commands[kubectl] )); then
      source <(kubectl completion zsh)
    fi
    # <<< Kubectl completions

    # >>> uv completions
    # https://docs.astral.sh/uv/cli/completion/
    if (( $+commands[uv] )); then
      source <(uv generate-shell-completion zsh)
    fi
    # <<< uv completions
  '';
}
