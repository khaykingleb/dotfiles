{ ... }:
let
  skillsDirectories = {
    source = ./skills;
    recursive = true;
  };
in
{
  imports = [ ./rules.nix ];

  home.file = {
    ".claude/skills" = skillsDirectories;
    ".cursor/skills" = skillsDirectories;
  };
}
