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

uninstall-nix:  ## Uninstall Nix
	@echo "Uninstalling Nix."
	@/nix/nix-installer uninstall
.PHONY: uninstall-nix

##=============================================================================
##@ Darwin
##=============================================================================

apply-darwin-macbook-m1: ## Apply Nix Darwin configuration for Macbook M1
	@echo "Applying Nix Darwin configuration for Macbook M1."
	@nix run nix-darwin -- switch --flake .#macbook-m1 --show-trace
.PHONY: apply-darwin-macbook-m1

apply-darwin-macbook-m4: ## Apply Nix Darwin configuration for Macbook M4
	@echo "Applying Nix Darwin configuration for Macbook M4."
	@nix run nix-darwin -- switch --flake .#macbook-m4 --show-trace
.PHONY: apply-darwin-macbook-m4

##=============================================================================
##@ Misc
##=============================================================================

pre-commit-autoupdate: ## Update pre-commit hooks
	@pre-commit autoupdate
.PHONY: pre-commit-autoupdate

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






# install-darwin:  ## Install Nix Darwin
# 	@echo "Installing Nix Darwin."
# 	@nix run nix-darwin -- switch --flake .
# .PHONY: install-darwin

# uninstall-darwin:  ## Uninstall Nix Darwin
# 	@echo "Uninstalling Nix Darwin."
# 	@darwin-uninstaller
# .PHONY: uninstall-darwin

# apply-darwin-configuration:  ## Apply Nix Darwin configuration
# 	@echo "Applying Nix Darwin configuration."
# 	@darwin-rebuild switch --flake .#khaykingleb-macbook
# .PHONY: apply-darwin-configuration

# apply-home-manager:  ## Apply Nix Home Manager configuration
# 	@echo "Applying Nix Home Manager configuration."
# 	@home-manager switch --flake .#khaykingleb-macbook
# .PHONY: apply-home-manager
