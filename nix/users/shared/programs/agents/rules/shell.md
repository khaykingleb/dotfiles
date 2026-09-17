# Shell

- Format POSIX and Bash code with `shfmt` and check it with `shellcheck`. Preserve idiomatic Zsh syntax in Zsh-specific files.
- Quote parameter expansions unless word splitting or glob expansion is intentional.
- Use arrays for argument lists instead of constructing commands as strings.
- Check command availability before invoking optional tools.
- Preserve Home Manager's `$DRY_RUN_CMD` for activation-script mutations.
- Use strict mode in standalone Bash scripts when its failure semantics are appropriate. Do not add it blindly to sourced fragments.
