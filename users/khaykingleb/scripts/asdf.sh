#!/bin/bash

install_plugin() {
    plugin=$1
    version=$2
    echo "Installing $plugin $version..."
    asdf plugin add "$plugin" 2>/dev/null || true
    asdf install "$plugin" "$version" || echo "Failed to install $plugin $version"
    asdf global "$plugin" "$version"
}

plugins=(
    "python 3.12.9"
    "uv 0.6.6"
    "rust 1.84.1"
    "golang 1.23.5"
    "terraform 1.5.7"
    "opentofu 1.9.0"
    "tflint 0.55.1"
    "terraform-docs 0.19.0"
    "kubectl 1.32.1"
    "helm 3.17.0"
    "k3s 1.31.5+k3s1"
    "k3d 5.8.1"
    "k9s 0.32.7"
    "krew 0.4.5"
    "kubeconform 0.7.0"
    "kube-linter 0.7.2"
    "kustomize 5.6.0"
    "tilt 0.33.22"
    "argocd 2.10.1"
    "awscli 2.23.3"
    "nodejs 23.6.1"
    "pnpm 9.15.5"
    "yarn 1.22.22"
    "supabase-cli 2.12.1"
    "postgres 17.2"
    "ollama 0.6.3"
    "pre-commit 4.1.0"
    "direnv 2.35.0"
    "1password-cli 2.30.3"
)
asdf plugin add supabase-cli https://github.com/gavinying/asdf-supabase-cli.git 2>/dev/null || true
for plugin in "${plugins[@]}"; do
    IFS=' ' read -r name version <<< "$plugin"
    install_plugin "$name" "$version"
done

# Install krew plugins
kubectl krew install neat
