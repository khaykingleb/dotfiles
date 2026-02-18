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
    "python 3.12.9"  # programming language
    "uv 0.8.13"  # python package manager
    "rust 1.84.1"  # programming language
    "golang 1.25.5"  # programming language
    "terraform 1.12.1"  # IaC provisioning
    "opentofu 1.9.0"  # fork of terraform since license changed
    "tflint 0.55.1"  # terraform linter
    "terraform-docs 0.19.0"  # terraform documentation generator
    "kubectl 1.32.1"  # k8s cli
    "helm 3.17.0"  # k8s package manager
    "k3s 1.31.5+k3s1"  # lightweight k8s
    "k3d 5.8.1"  # wrapper to run k3s in docker
    "k9s 0.50.9"  # UI to interact with k8s clusters
    "krew 0.4.5"  # k8s plugin manager
    "kubectx 0.9.5"  # k8s context switcher
    "kubie 0.26.0"  # more powerful k8s context switcher
    "kubeconform 0.7.0"  # k8s schema validator
    "kube-linter 0.7.2"  # k8s linter
    "kustomize 5.6.0"  # k8s manifest generator
    "tilt 0.33.22"  # k8s developer experience
    "argocd 3.1.8"  # k8s gitops
    "awscli 2.23.3"  # aws cli
    "nodejs 23.6.1"  # javascript runtime
    "pnpm 9.15.5"  # javascript package manager
    "yarn 1.22.22"  # javascript package manager
    "supabase-cli 2.12.1"  # baas with postgres
    "postgres 17.2"  # postgres database client
    "ollama 0.6.3"  # local llm hosting
    "pre-commit 4.3.0"  # git commit hook manager
    "direnv 2.35.0"  # environment manager
    "1password-cli 2.30.3"  # password manager
    "buf 1.61.0"  # protobuf tooling
    "just 1.46.0" # building tool, alternative to make
)
asdf plugin add supabase-cli https://github.com/gavinying/asdf-supabase-cli.git 2>/dev/null || true
for plugin in "${plugins[@]}"; do
    IFS=' ' read -r name version <<< "$plugin"
    install_plugin "$name" "$version"
done

# Install krew plugins for k8s
kubectl krew install neat
