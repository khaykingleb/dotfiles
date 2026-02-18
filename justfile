[private]
default:
    @just --list --unsorted --list-heading $'Available commands:\n'

DS_NIX_INSTALLER_VERSION := "v0.32.2"

[group('nix')]
[doc('Install Nix with Determinate Systems Nix Installer')]
nix-install:
    @echo "Installing Nix using Determinate Systems installer ({{ DS_NIX_INSTALLER_VERSION }})."
    @if command -v nix >/dev/null 2>&1; then \
        echo "Nix is already installed. Run 'nix --version' to check version."; \
    else \
        curl --proto '=https' --tlsv1.2 -sSf -L "https://install.determinate.systems/nix/tag/{{ DS_NIX_INSTALLER_VERSION }}" | sh -s -- install && \
        echo "Nix installation complete. Please restart your shell."; \
    fi

[group('nix')]
[doc('Upgrade Nix')]
nix-upgrade:
    @echo "Upgrading Nix."
    @sudo -i nix upgrade-nix

[group('nix')]
[doc('Uninstall Nix')]
nix-uninstall:
    @echo "Uninstalling Nix."
    @/nix/nix-installer uninstall

[group('nix')]
[doc('Apply nix-darwin configuration for a given host')]
nix-apply host:
    @echo "Applying nix-darwin configuration for {{ host }}."
    @nix run nix-darwin -- switch --flake .#{{ host }} --show-trace

[group('nix')]
[doc('Update the flake.lock file')]
nix-update-flake:
    @nix flake update

[group('nix')]
[doc('Collect Nix garbage (remove unused packages)')]
nix-gc:
    @nix-collect-garbage

[group('misc')]
[doc('Initialize pre-commit hooks')]
pre-commit-init:
    @echo "Installing pre-commit hooks."
    @pre-commit install
    @pre-commit install --hook-type commit-msg

[group('misc')]
[doc('Update pre-commit hooks')]
pre-commit-update:
    @pre-commit autoupdate

[group('misc')]
[doc('Run pre-commit hooks on all files')]
pre-commit-run:
    @pre-commit run --all-files

[group('misc')]
[doc('Install asdf plugins')]
asdf-install:
    @./users/shared/scripts/asdf.sh
