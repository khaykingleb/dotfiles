[private]
default:
    @just --list --unsorted --list-heading $'Available commands:\n'

[group('nix')]
[doc('Apply nix-darwin configuration for a given host')]
nix-apply host:
    @nh darwin switch . -H {{ host }}

[group('nix')]
[doc('Update all or selected flake inputs')]
nix-update-flake *inputs='':
    @nix flake update {{ inputs }}

[group('nix')]
[doc('Clean old Nix generations while preserving recent rollback history')]
nix-clean:
    @nh clean all --keep 5 --keep-since 7d

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
[doc('Reconcile asdf plugins and tool versions')]
asdf-sync:
    @./users/shared/programs/asdf/install.sh
