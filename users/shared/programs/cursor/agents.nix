{ lib, pkgs, ... }:
let
  ruleSources = (import ../agents/rules.nix { inherit lib pkgs; }).cursor;
  ruleFiles = lib.mapAttrs' (
    ruleName: source: lib.nameValuePair ".cursor/rules/${ruleName}.mdc" { inherit source; }
  ) ruleSources;

  skillSources = (import ../agents/skills.nix { inherit lib; }) ../agents/skills;
  skillFiles = lib.mapAttrs' (
    skillName: source:
    lib.nameValuePair ".cursor/skills/${skillName}" {
      inherit source;
      recursive = true;
    }
  ) skillSources;
in
{
  home.file = ruleFiles // skillFiles;
}
