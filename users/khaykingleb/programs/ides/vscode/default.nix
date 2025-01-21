{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      # Languages
      ## Python
      {
        name = "python";
        publisher = "ms-python";
        version = "2024.22.2";
        sha256 = "uVv4kpTf0W82Gvoju0Q/HKf6SpN2mwuYO7NItlRoezI=";
      }
      {
        name = "vscode-pylance";
        publisher = "ms-python";
        version = "2024.12.1";
        sha256 = "LpHbXthVHvrVZ1xqBTDfF1RjzgEilQVVHfy0tlum/BU=";
      }
      ## Rust
      {
        name = "rust-bundle";
        publisher = "1yib";
        version = "1.0.0";
        sha256 = "G2vHX9LBKmUhd5K3oKAojcfVIWydjPS03xkBW+cepaU=";
      }
      {
        name = "rust-analyzer";
        publisher = "rust-lang";
        version = "0.3.2273";
        sha256 = "y5TyM6lGu/LTMja184weHcHNnsqlF765zcDRybjHVxA=";
      }
      {
        name = "rust-syntax";
        publisher = "dustypomerleau";
        version = "0.6.1";
        sha256 = "o9iXPhwkimxoJc1dLdaJ8nByLIaJSpGX/nKELC26jGU=";
      }
      ## Go
      {
        name = "go";
        publisher = "golang";
        version = "0.44.0";
        sha256 = "ecLpTPMonwCNfZQ3cmuIzFHkSUb37JWLCDy6oODnc0c=";
      }
      ## C++
      {
        name = "better-cpp-syntax";
        publisher = "jeff-hykin";
        version = "1.27.1";
        sha256 = "GO/ooq50KLFsiEuimqTbD/mauQYcD/p2keHYo/6L9gw=";
      }
      # {
      #   name = "clangd";
      #   publisher = "llvm-vs-code-extensions";
      #   version = "0.1.33";
      #   sha256 = "1111111111111111111111111111111111111111111111111111111111111111";
      # }
      {
        name = "cmake-language-support-vscode";
        publisher = "josetr";
        version = "0.0.9";
        sha256 = "LNtXYZ65Lka1lpxeKozK6LB0yaxAjHsfVsCJ8ILX8io=";
      }
      ## Nix
      {
        name = "nix-ide";
        publisher = "jnoortheen";
        version = "0.4.2";
        sha256 = "WOzHHQZlTdDoVB90GYhuEORNPLyv/lWZBNMrIzBTWW8=";
      }

      # DevOps
      {
        name = "hcl";
        publisher = "hashicorp";
        version = "0.6.0";
        sha256 = "Za2ODrsHR/y0X/FOhVEtbg6bNs439G6rlBHW84EZS60=";
      }
      {
        name = "terraform";
        publisher = "hashicorp";
        version = "2.34.2";
        sha256 = "lU1SrAPDCCSanJaB0xRVFWmi9a1J4Btj9oORatToM6w=";
      }
      {
        name = "ansible";
        publisher = "redhat";
        version = "25.1.0";
        sha256 = "/kLg+msRu6GvkENVu3jw9uDbfEo/x0eZgsKfXvLaO3I=";
      }
      {
        name = "vscode-yaml";
        publisher = "redhat";
        version = "1.15.0";
        sha256 = "NhlLNYJryKKRv+qPWOj96pT2wfkiQeqEip27rzl2C0M=";
      }
      {
        name = "even-better-toml";
        publisher = "tamasfe";
        version = "0.21.2";
        sha256 = "IbjWavQoXu4x4hpEkvkhqzbf/NhZpn8RFdKTAnRlCAg=";
      }
      {
        name = "jinja";
        publisher = "wholroyd";
        version = "0.0.8";
        sha256 = "kU2uMIBChHOE76npA9u1CSJCMPHK0hj/2vasVTx9ydI=";
      }
      {
        name = "vscode-docker";
        publisher = "ms-azuretools";
        version = "1.29.3";
        sha256 = "z0RqFos0ZG2Id/alUBZJyroX3coTcJ+x2R8v4FD2Zcg=";
      }
      {
        name = "vscode-kubernetes-tools";
        publisher = "ms-kubernetes-tools";
        version = "1.3.18";
        sha256 = "umVWpfhXW00R0ZNRkzFler68ZK5GXMEZUnJ2DcC+Cxk=";
      }
      {
        name = "makefile-tools";
        publisher = "ms-vscode";
        version = "0.11.13";
        sha256 = "j6u3IWFz6ion42T8QKtdQN2GWyX2qdPDdLmRduGvtcw=";
      }

      # Backend
      {
        name = "vscode-protolint";
        publisher = "plex";
        version = "0.8.0";
        sha256 = "DTKWQYRQkV1VTCnuDxakI7mjyMFF55Ppss/QRwjWIog=";
      }
      {
        name = "vscode-proto3";
        publisher = "zxh404";
        version = "0.5.5";
        sha256 = "Em+w3FyJLXrpVAe9N7zsHRoMcpvl+psmG1new7nA8iE=";
      }

      # Frontend
      {
        name = "vscode-tailwindcss";
        publisher = "bradlc";
        version = "0.12.18";
        sha256 = "fom4hQ+2pWKSTgFEB3cycKQLyaJPEPmf5t2/Y+GierM=";
      }
      {
        name = "vscode-eslint";
        publisher = "dbaeumer";
        version = "3.0.10";
        sha256 = "EVmexnTIQQDmj25/rql3eCfJd47zRui3TpHol6l0Vgs=";
      }
      {
        name = "prettier-vscode";
        publisher = "esbenp";
        version = "11.0.0";
        sha256 = "pNjkJhof19cuK0PsXJ/Q/Zb2H7eoIkfXJMLZJ4lDn7k=";
      }
      {
        name = "code-spell-checker";
        publisher = "streetsidesoftware";
        version = "4.0.34";
        sha256 = "XREhBFc/UxvVxA4jlcEqym1D/pA1lmU0/PHX84BL2SQ=";
      }

      # Research
      {
        name = "jupyter";
        publisher = "ms-toolsai";
        version = "2024.11.0";
        sha256 = "BwZLF52ilEaLU6swUFEa+PtrxzsFOLIYd8TVD7xRgPg=";
      }
      {
        name = "jupyter-renderers";
        publisher = "ms-toolsai";
        version = "1.0.21";
        sha256 = "RX3LgpwD8/0TapOBJO4UuiShxyarbs9peX40xwITTKs=";
      }
      {
        name = "mplstyle";
        publisher = "yy0931";
        version = "1.14.4";
        sha256 = "jeG2mvJcuuBtaAG84F9dSJE1Y8ze0yiseXIQ2FcK8ss=";
      }
      {
        name = "wav-preview";
        publisher = "sukumo28";
        version = "2.6.0";
        sha256 = "4DfVeae/9l3Fq8DymW7RP1HWVaEPhYd1KdJhrO8KKAs=";
      }
      {
        name = "vscode-latex";
        publisher = "mathematic";
        version = "1.3.0";
        sha256 = "/mbMpel9JHmSh0GN/wIbFi/0voaQBxGn0SueZlUFZUc=";
      }

      # Misc
      {
        name = "remote-ssh";
        publisher = "ms-vscode-remote";
        version = "0.116.1";
        sha256 = "onDOybZsYMZltaVDP70quvZ3pejPsc0qvM+e2aLisXQ=";
      }
      {
        name = "remote-ssh-edit";
        publisher = "ms-vscode-remote";
        version = "0.87.0";
        sha256 = "yeX6RAJl07d+SuYyGQFLZNcUzVKAsmPFyTKEn+y3GuM=";
      }
      {
        name = "remote-explorer";
        publisher = "ms-vscode";
        version = "0.4.3";
        sha256 = "772l0EnAWXLg53TxPZf93js/W49uozwdslmzNwD1vIk=";
      }
      {
        name = "vsliveshare";
        publisher = "ms-vsliveshare";
        version = "1.0.5948";
        sha256 = "KOu9zF5l6MTLU8z/l4xBwRl2X3uIE15YgHEZJrKSHGY=";
      }
      {
        name = "vscode-github-actions";
        publisher = "github";
        version = "0.27.0";
        sha256 = "sZ831fPgy/HGsXL1gTezbTsnVcYjwxEd79JfMu1jaGo=";
      }
      {
        name = "vscode-pull-request-github";
        publisher = "github";
        version = "0.102.0";
        sha256 = "5MgrZ+Ba/+KO6Ya5bpsXdmmLVHxDqvwGtJfaJnAF9oA=";
      }
      {
        name = "git-graph";
        publisher = "mhutchie";
        version = "1.30.0";
        sha256 = "sHeaMMr5hmQ0kAFZxxMiRk6f0mfjkg2XMnA4Gf+DHwA=";
      }
      {
        name = "gitblame";
        publisher = "waderyan";
        version = "11.1.1";
        sha256 = "NCA6oV0n6fJpyssmh5sx0VDE1yuiY6xm1lWjqm8BpgM=";
      }
      {
        name = "gitignore";
        publisher = "codezombiech";
        version = "0.9.0";
        sha256 = "IHoF+c8Rsi6WnXoCX7x3wKyuMwLh14nbL9sNVJHogHM=";
      }
      {
        name = "dotenv";
        publisher = "mikestead";
        version = "1.0.1";
        sha256 = "dieCzNOIcZiTGu4Mv5zYlG7jLhaEsJR05qbzzzQ7RWc=";
      }
      {
        name = "logfilehighlighter";
        publisher = "emilast";
        version = "3.4.0";
        sha256 = "qwI/je5hkJ9CWJ9D46ckMsT1mAYCV041iKbUwDdh/dw=";
      }
      {
        name = "dependi";
        publisher = "fill-labs";
        version = "0.7.13";
        sha256 = "Xn2KEZDQ11LDfUKbIrJtQNQXkcusyrL/grDyQxUmTbc=";
      }
      {
        name = "pdf";
        publisher = "tomoki1207";
        version = "1.2.2";
        sha256 = "i3Rlizbw4RtPkiEsodRJEB3AUzoqI95ohyqZ0ksROps=";
      }
      {
        name = "icons";
        publisher = "tal7aouy";
        version = "3.8.0";
        sha256 = "PdhNFyVUWcOfli/ZlT+6TmtWrV31fBP1E1Vd4QWOY+A=";
      }
      {
        name = "markdown-preview-github-styles";
        publisher = "bierner";
        version = "2.1.0";
        sha256 = "6Gs05RcYbeKBCi67K33KIpL0aGLGykYgyy3IPlx7ybo=";
      }
      {
        name = "vscode-office";
        publisher = "cweijan";
        version = "3.5.0";
        sha256 = "NSNqnPXiKPeRHpC1JTG24y1cEHldqUIHl56TFwlDiZ8=";
      }
      {
        name = "vscode-peacock";
        publisher = "johnpapa";
        version = "4.2.2";
        sha256 = "sha256-VTRTQpIiFUxc3qF+E1py1+ns93i918QeTAoWAf7NLP0=";
      }
    ];

    userSettings = {
      "editor.rulers" = [ 79 100 ];
      "editor.formatOnSave" = true;
      "editor.formatOnPaste" = true;

      "terminal.integrated.fontFamily" = "MesloLGM Nerd Font Mono";

      "files.autoSave" = "onFocusChange";
      "files.trimTrailingWhitespace" = true;
      "files.insertFinalNewline" = true;
      "files.trimFinalNewlines" = true;

      # Languages
      ## Nix
      "nix.enableLanguageServer" = true;
      "nix.serverSettings" = {
        "nil" = {
          "formatting" = {
            "command" = [
              "nixpkgs-fmt"
            ];
          };
        };
      };
    };
  };
}
