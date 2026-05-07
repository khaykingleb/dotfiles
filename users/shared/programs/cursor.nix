# Cursor rules and Claude Code global instructions
{ ... }:
let
  rules = [
    "code-style.mdc"
    "dotfiles.mdc"
    "git.mdc"
    "go.mdc"
    "kubernetes.mdc"
    "python.mdc"
    "rust.mdc"
  ];

  skills = [
    "linear-ticket-writing"
    "pr-description"
  ];
in
{
  home.file =
    {
      ".cursor/mcp.json".source = ./cursor/mcp.json;
    }
    //
    (builtins.listToAttrs (map
      (name: {
        name = ".cursor/rules/${name}";
        value.source = ./cursor/rules/${name};
      })
      rules))
    // (builtins.listToAttrs (map
      (name: {
        name = ".cursor/skills/${name}/SKILL.md";
        value.source = ./cursor/skills/${name}/SKILL.md;
      })
      skills));
}
