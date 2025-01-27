#! /bin/bash

install_conda_macos_silicon() {
    curl -O https://repo.anaconda.com/archive/Anaconda3-2024.10-1-MacOSX-arm64.sh \
        && sh Anaconda3-2024.10-1-MacOSX-arm64.sh -b -p ~/anaconda3 \
        && rm Anaconda3-2024.10-1-MacOSX-arm64.sh
}

"$@"
