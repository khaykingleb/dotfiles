{ config, lib, ... }:
let
  extensions = [
    # Python
    "ms-python.python"
    "magicstack.magicpython"
    "ms-python.debugpy"
    "charliermarsh.ruff"
    "ms-python.vscode-pylance"

    # Rust
    "1yib.rust-bundle"
    "dustypomerleau.rust-syntax"
    "rust-lang.rust-analyzer"

    # Go
    "golang.go"

    # C++
    "llvm-vs-code-extensions.vscode-clangd"
    "jeff-hykin.better-cpp-syntax"
    "josetr.cmake-language-support-vscode"

    # DevOps
    "ms-azuretools.vscode-docker"
    "ms-kubernetes-tools.vscode-kubernetes-tools"
    "hashicorp.hcl"
    "hashicorp.terraform"
    "redhat.ansible"
    "redhat.vscode-yaml"
    "tamasfe.even-better-toml"
    "wholroyd.jinja"
    "ms-vscode.makefile-tools"
    "jnoortheen.nix-ide"
    "codezombiech.gitignore"
    "eamodio.gitlens"
    "waderyan.gitblame"
    "donjayamanne.githistory"
    "mhutchie.git-graph"

    # Backend
    "plex.vscode-protolint"
    "zxh404.vscode-proto3"

    # Frontend
    "dbaeumer.vscode-eslint"
    "esbenp.prettier-vscode"
    "stylelint.vscode-stylelint"
    "bradlc.vscode-tailwindcss"
    "naumovs.color-highlight"
    "streetsidesoftware.code-spell-checker"

    # Research and writing
    "ms-toolsai.jupyter"
    "ms-toolsai.jupyter-renderers"
    "ms-toolsai.jupyter-keymap"
    "ms-toolsai.vscode-jupyter-slideshow"
    "ms-toolsai.vscode-jupyter-cell-tags"
    "yy0931.mplstyle"
    "james-yu.latex-workshop"
    "tintinweb.graphviz-interactive-preview"

    # Misc
    "ms-vsliveshare.vsliveshare"
    "ms-vscode-remote.remote-containers"
    "ms-vscode-remote.remote-ssh-edit"
    "ms-vscode-remote.remote-ssh"
    "ms-vscode.remote-explorer"
    "yzhang.markdown-all-in-one"
    "davidanson.vscode-markdownlint"
    "ms-dotnettools.vscode-dotnet-runtime"
    "emilast.logfilehighlighter"
    "mikestead.dotenv"
    "fill-labs.dependi"
    "sukumo28.wav-preview"
    "pkief.material-icon-theme"
  ];
in
{
  home = {
    # NOTE: This creates a symlink from ~/Library/Application Support/Code/User/settings.json
    # to the settings.json file in the repo and not copies the file into the Nix store
    # Thus, the settings.json is writable by the user
    file."Library/Application Support/Code/User/settings.json" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/dotfiles/users/khaykingleb/programs/vscode/settings.json";
    };

    # Adapted from https://github.com/ryanccn/flake/blob/b9832c59cf9d0362c2d20f838220bed434a0b45a/home/apps/vscode.nix#L214-L244.
    activation = {
      vscodeExtensions = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        code_bin="/opt/homebrew/bin/code"

        if ! command -v "$code_bin" &> /dev/null; then
          echo "VSCode CLI is not available"
          exit 0
        fi

        declare -A currentExtensions
        for extension in $("$code_bin" --list-extensions); do
          currentExtensions["$extension"]=1;
        done

        ${builtins.concatStringsSep "\n" (
          builtins.map (ext: ''
            if [[ -z "''${currentExtensions[${ext}]+unset}" ]]; then
              echo "Installing ${ext}"
              $DRY_RUN_CMD "$code_bin" --install-extension ${ext} &> /dev/null
            fi
            unset 'currentExtensions[${ext}]'
          '') extensions
        )}

        for ext in "''${!currentExtensions[@]}"; do
          echo "Uninstalling $ext"
          $DRY_RUN_CMD "$code_bin" --uninstall-extension $ext &> /dev/null
          unset 'currentExtensions[$ext]'
        done
      '';
    };
  };
}
