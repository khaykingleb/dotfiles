# Nix

- Format Nix files with `nixfmt`.
- Prefer native Nix data structures over parsing generated text to recover configuration.
- Use `lib.getExe` or `lib.getExe'` when invoking binaries supplied by Nix packages.
- Escape dynamic shell arguments with `lib.escapeShellArg`.
- Distinguish Nix interpolation (`${...}`) from escaped shell interpolation (`''${...}`) in indented strings.
- Evaluate every affected flake output or system configuration after changing modules.
