#! /bin/bash

plugins_to_add=(
    "tflint"
    "terraform-docs"
    "pnpm"
    "yarn"
    "supabase-cli https://github.com/gavinying/asdf-supabase-cli.git"
)
for plugin in "${plugins_to_add[@]}"; do
    asdf plugin-add $plugin
done

declare -A plugins_to_install=(
    ["direnv"]="2.35.0"
    ["pre-commit"]="4.1.0"
    ["python"]="3.12.9"
    ["poetry"]="2.0.1"
    ["rust"]="1.84.1"
    ["golang"]="1.23.5"
    ["opentofu"]="1.9.0"
    ["terraform"]="1.5.7"
    ["kubectl"]="1.32.1"
    ["awscli"]="2.23.3"
    ["nodejs"]="23.6.1"
    ["supabase-cli"]="2.9.1"
)
for plugin in "${!plugins_to_install[@]}"; do
    asdf plugin-add $plugin
    asdf install $plugin "${plugins_to_install[$plugin]}"
    asdf global $plugin "${plugins_to_install[$plugin]}"
done
