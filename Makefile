.DEFAULT_GOAL = help

DS_NIX_INSTALLER_VERSION := "v0.32.2"

##=============================================================================
##@ Nix
##=============================================================================

nix-install:  ## Install Nix with Determinate Systems Nix Installer
	@echo "Installing Nix using Determinate Systems installer (${DS_NIX_INSTALLER_VERSION})."
	@if command -v nix >/dev/null 2>&1; then echo "Nix is already installed. Run 'nix --version' to check version." && exit 0; else \
		curl --proto '=https' --tlsv1.2 -sSf -L "https://install.determinate.systems/nix/tag/${DS_NIX_INSTALLER_VERSION}" | sh -s -- install && \
		echo "Nix installation complete. Please restart your shell."; \
	fi
.PHONY: nix-install

nix-upgrade:  ## Upgrade Nix
	@echo "Upgrading Nix."
	@sudo -i nix upgrade-nix
.PHONY: nix-upgrade

nix-uninstall:  ## Uninstall Nix
	@echo "Uninstalling Nix."
	@/nix/nix-installer uninstall
.PHONY: nix-uninstall

nix-darwin-apply-%: ## Apply nix-darwin configuration
	@echo "Applying nix-darwin configuration for $*"
	@nix run nix-darwin -- switch --flake .#$* --show-trace

nix-garbage-collect: ## Collect Nix garbage (remove unused packages)
	@nix-collect-garbage
.PHONY: nix-garbage-collect

##=============================================================================
##@ Misc
##=============================================================================

pre-commit-init: ## Initialize pre-commit hooks
	@echo "Installing pre-commit hooks."
	@pre-commit install
	@pre-commit install --hook-type commit-msg
.PHONY: pre-commit-init

pre-commit-autoupdate: ## Update pre-commit hooks
	@pre-commit autoupdate
.PHONY: pre-commit-autoupdate

pre-commit-run-all: ## Run pre-commit hooks on all files
	@pre-commit run --all-files
.PHONY: pre-commit-run-all

asdf-install: ## Install asdf plugins
	@./users/shared/scripts/asdf.sh
.PHONY: asdf-install

##=============================================================================
##@ Helper
##=============================================================================

help: ## Display help
	@awk 'BEGIN {FS = ":.*##"; \
		printf "\nUsage:\n  make \033[36m<target>\033[0m\n\n"} \
		/^[a-zA-Z0-9_-]+%?:.*?##/ { \
			printf "  \033[36m%-30s\033[0m %s\n", $$1, $$2 \
		} \
		/^##@/ { \
			printf "\n\033[1m%s\033[0m\n", substr($$0, 5) \
		}' $(MAKEFILE_LIST)
.PHONY: help
