{ lib, pkgs, ... }:
let
  mcpServers = (import ./agents/mcp.nix { inherit lib pkgs; }).cursor;

  skillSources = (import ../../shared/programs/agents/skills.nix { inherit lib; }) ./agents/skills;
  skillFiles = lib.mapAttrs' (
    skillName: source:
    lib.nameValuePair ".cursor/skills/${skillName}" {
      inherit source;
      recursive = true;
    }
  ) skillSources;
in
{
  home.file = skillFiles // {
    # Cursor keeps global MCP configuration in a dedicated file, so Home Manager can own it directly.
    ".cursor/mcp.json".text = builtins.toJSON { inherit mcpServers; };
  };
}
