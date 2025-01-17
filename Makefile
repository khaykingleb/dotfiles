.DEFAULT_GOAL = help

DS_NIX_INSTALLER_VERSION := "v0.32.2"

##=============================================================================
##@ Nix
##=============================================================================

install-nix:  ## Install Nix with Determinate Systems Nix Installer
	@echo "Installing Nix using Determinate Systems installer (${DS_NIX_INSTALLER_VERSION})."
	@if command -v nix >/dev/null 2>&1; then echo "Nix is already installed. Run 'nix --version' to check version." && exit 0; else \
		curl --proto '=https' --tlsv1.2 -sSf -L "https://install.determinate.systems/nix/tag/${DS_NIX_INSTALLER_VERSION}" | sh -s -- install && \
		echo "Nix installation complete. Please restart your shell."; \
	fi
.PHONY: install-nix

upgrade-nix:  ## Upgrade Nix
	@echo "Upgrading Nix."
	@sudo -i nix upgrade-nix
.PHONY: upgrade-nix

uninstall-nix:  ## Uninstall Nix
	@echo "Uninstalling Nix."
	@/nix/nix-installer uninstall
.PHONY: uninstall-nix

apply-nix-darwin: ## Apply nix-darwin configuration
	@echo "Applying nix-darwin configuration."
	@darwin-rebuild switch --flake .#macbook --show-trace
.PHONY: apply-nix-darwin

uninstall-nix-darwin:  ## Uninstall nix-darwin
	@echo "Uninstalling nix-darwin."
	@darwin-uninstaller
.PHONY: uninstall-nix-darwin

#TODO: move to user packages
install-nil: ## Install Nix Language Server
	@nix profile install nixpkgs#nil
.PHONY: install-nil

uninstall-nil: ## Uninstall Nix Language Server
	@nix profile remove nixpkgs#nil
.PHONY: uninstall-nil

##=============================================================================
##@ Misc
##=============================================================================

PLUGINS := \
	pre-commit https://github.com/jonathanmorley/asdf-pre-commit.git

init-prerequisites: ## Initialize pre-commit hooks
	@echo "Checking and installing required plugins."
	@echo "${PLUGINS}" | tr ' ' '\n' | paste - - | while read -r plugin url; do \
		if asdf plugin-list | grep -q $$plugin; then \
			echo "Plugin '$$plugin' is already installed."; \
		else \
			echo "Adding plugin '$$plugin'."; \
			asdf plugin-add $$plugin $$url; \
		fi; \
	done
	@echo  "Installing specified versions."
	@asdf install
	@echo  "Currently installed versions:"
	@asdf current
.PHONY: init-prerequisites

init-pre-commit: init-prerequisites  ## Initialize pre-commit hooks
	@echo "Installing pre-commit hooks."
	@pre-commit install
	@pre-commit install --hook-type commit-msg
.PHONY: init-pre-commit

pre-commit-autoupdate: ## Update pre-commit hooks
	@pre-commit autoupdate
.PHONY: pre-commit-autoupdate

pre-commit-run-all: ## Run pre-commit hooks
	@pre-commit run --all-files
.PHONY: pre-commit-run-all

##@ Helper
##=============================================================================

help: ## Display help
	@awk 'BEGIN {FS = ":.*##"; \
		printf "\nUsage:\n  make \033[36m<target>\033[0m\n\n"} \
		/^[a-zA-Z0-9_-]+:.*?##/ { \
			printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2 \
		} \
		/^##@/ { \
			printf "\n\033[1m%s\033[0m\n", substr($$0, 5) \
		}' $(MAKEFILE_LIST)
.PHONY: help
