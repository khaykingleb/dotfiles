# Cursor rules and Claude Code global instructions
{ ... }:
let
  rules = [
    "code-style.mdc"
    "git.mdc"
    "go.mdc"
    "python.mdc"
    "rust.mdc"
  ];
in
{
  home.file = builtins.listToAttrs (map
    (name: {
      name = ".cursor/rules/${name}";
      value.source = ./cursor/rules/${name};
    })
    rules);
}
