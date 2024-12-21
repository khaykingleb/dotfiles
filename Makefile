.DEFAULT_GOAL = help

DS_NIX_INSTALLER_VERSION := "v0.32.2"

##=============================================================================
##@ Initialization
##=============================================================================

install-nix:  ## Install Nix with Determinate Systems Nix Installer
	@echo "Installing Nix using Determinate Systems installer (${DS_NIX_INSTALLER_VERSION})."
	@if command -v nix >/dev/null 2>&1; then echo "Nix is already installed. Run 'nix --version' to check version." && exit 0; else \
		curl --proto '=https' --tlsv1.2 -sSf -L "https://install.determinate.systems/nix/tag/${DS_NIX_INSTALLER_VERSION}" | sh -s -- install && \
		echo "Nix installation complete. Please restart your shell."; \
	fi
.PHONY: install-nix

install-configuration:  ## Install Nix Darwin configuration
	@echo "Installing Nix Darwin configuration."
	@nix run nix-darwin -- switch --flake .#khaykingleb-macbook
.PHONY: install-configuration

apply-configuration:  ## Apply Nix Darwin configuration
	@echo "Applying Nix Darwin configuration."
	@darwin-rebuild switch --flake .#khaykingleb-macbook
.PHONY: apply-configuration

##=============================================================================
##@ Helper
##=============================================================================

help: ## Display help
	@awk 'BEGIN {FS = ":.*##"; \
		printf "\nUsage:\n  make \033[36m<target>\033[0m\n\n"} \
		/^[a-zA-Z_-]+:.*?##/ { \
			printf "  \033[36m%-24s\033[0m %s\n", $$1, $$2 \
		} \
		/^##@/ { \
			printf "\n\033[1m%s\033[0m\n", substr($$0, 5) \
		}' $(MAKEFILE_LIST)
.PHONY: help
