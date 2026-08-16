# Claude Code global configuration
{ lib, pkgs, ... }:
let
  ruleSources = (import ./agents/rules.nix { inherit lib pkgs; }).claude;
  ruleFiles = lib.mapAttrs' (
    ruleName: source: lib.nameValuePair ".claude/rules/${ruleName}.md" { inherit source; }
  ) ruleSources;

  skillSources = (import ./agents/skills.nix { inherit lib; }) ./agents/skills;
  skillFiles = lib.mapAttrs' (
    skillName: source:
    lib.nameValuePair ".claude/skills/${skillName}" {
      inherit source;
      recursive = true;
    }
  ) skillSources;
in
{
  home.file = ruleFiles // skillFiles;
}
