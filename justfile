[private]
default:
    @just --list --unsorted --list-heading $'Available commands:\n'

[doc('Install repository hooks')]
setup:
    @pre-commit install

[doc('Install configured asdf tools and Krew plugins')]
sync:
    @./nix/users/shared/programs/asdf/install.sh
    @./nix/users/shared/programs/krew/install.sh

[doc('Manage Terraform infrastructure')]
mod terraform

[doc('Manage Nix configurations and generations')]
mod nix
