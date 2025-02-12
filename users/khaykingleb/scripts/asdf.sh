#! /bin/bash

custom_plugins_to_add=(
    "supabase-cli https://github.com/gavinying/asdf-supabase-cli.git"
)
for plugin in "${custom_plugins_to_add[@]}"; do
    asdf plugin-add $plugin
done

declare -A plugins_to_install=(
    ["python"]="3.12.9"
    ["poetry"]="2.0.1"
    ["rust"]="1.84.1"
    ["golang"]="1.23.5"
    ["terraform"]="1.5.7"
    ["opentofu"]="1.9.0"
    ["tflint"]="0.55.1"
    ["terraform-docs"]="0.19.0"
    ["kubectl"]="1.32.1"
    ["helm"]="3.17.0"
    ["k3s"]="1.31.5+k3s1"
    ["k9s"]="0.32.7"
    ["k3d"]="5.8.1"
    ["tilt"]="0.33.22"
    ["awscli"]="2.23.3"
    ["nodejs"]="23.6.1"
    ["pnpm"]="9.15.5"
    ["yarn"]="1.22.22"
    ["supabase-cli"]="2.9.1"
    ["postgres"]="17.2"
    ["direnv"]="2.35.0"
    ["pre-commit"]="4.1.0"
)
for plugin in "${!plugins_to_install[@]}"; do
    asdf plugin-add $plugin
    asdf install $plugin "${plugins_to_install[$plugin]}"
    asdf global $plugin "${plugins_to_install[$plugin]}"
done
