#! /bin/bash

install_conda_macos_silicon() {
    if [ ! -d "$HOME/anaconda3" ]; then
        echo "Installing Anaconda..."
        /usr/bin/curl -O https://repo.anaconda.com/archive/Anaconda3-2024.10-1-MacOSX-arm64.sh \
            && sh Anaconda3-2024.10-1-MacOSX-arm64.sh -b -p ~/anaconda3 \
            && rm Anaconda3-2024.10-1-MacOSX-arm64.sh
    else
        echo "Anaconda is already installed, skipping installation..."
    fi
}

"$@"
