#!/bin/bash

asdf plugin add supabase-cli https://github.com/gavinying/asdf-supabase-cli.git 2>/dev/null || true

install_plugin() {
    plugin=$1
    version=$2
    echo "Installing $plugin $version..."
    asdf plugin add "$plugin" 2>/dev/null || true
    asdf install "$plugin" "$version" || echo "Failed to install $plugin $version"
    asdf global "$plugin" "$version"
}

install_plugin "python" "3.12.9"
install_plugin "uv" "0.6.6"
install_plugin "rust" "1.84.1"
install_plugin "golang" "1.23.5"
install_plugin "terraform" "1.5.7"
install_plugin "opentofu" "1.9.0"
install_plugin "tflint" "0.55.1"
install_plugin "terraform-docs" "0.19.0"
install_plugin "kubectl" "1.32.1"
install_plugin "helm" "3.17.0"
install_plugin "k3s" "1.31.5+k3s1"
install_plugin "k3d" "5.8.1"
install_plugin "k9s" "0.32.7"
install_plugin "tilt" "0.33.22"
install_plugin "argocd" "2.10.1"
install_plugin "awscli" "2.23.3"
install_plugin "nodejs" "23.6.1"
install_plugin "pnpm" "9.15.5"
install_plugin "yarn" "1.22.22"
install_plugin "supabase-cli" "2.12.1"
install_plugin "postgres" "17.2"
install_plugin "pre-commit" "4.1.0"
install_plugin "direnv" "2.35.0"
install_plugin "1password-cli" "2.30.3"
