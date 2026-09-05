{ lib, pkgs, ... }:
let
  mcpServers = (import ./agents/mcp.nix { inherit lib pkgs; }).claude;

  skillSources = (import ../../shared/programs/agents/skills.nix { inherit lib; }) ./agents/skills;
  skillFiles = lib.mapAttrs' (
    skillName: source:
    lib.nameValuePair ".claude/skills/${skillName}" {
      inherit source;
      recursive = true;
    }
  ) skillSources;

  removeMcpServer = serverName: ''
    if printf '%s\n' "$registered_mcp_servers" | grep -q ${lib.escapeShellArg "^${serverName}:"}; then
      $DRY_RUN_CMD claude mcp remove ${lib.escapeShellArg serverName} --scope user >/dev/null
    fi
  '';

  addMcpServer = serverName: serverConfiguration: ''
    $DRY_RUN_CMD claude mcp add-json --scope user ${lib.escapeShellArg serverName} ${lib.escapeShellArg (builtins.toJSON serverConfiguration)} >/dev/null
  '';
in
{
  home.file = skillFiles;

  # Preserve Claude's mutable user settings while enforcing attribution preferences.
  home.activation.claudeAttribution = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    settings_file="$HOME/.claude/settings.json"

    if [[ -v DRY_RUN ]]; then
      verboseEcho "Would disable Claude commit and PR attribution"
    else
      install -d -m 700 "$(dirname "$settings_file")"

      if [[ -f "$settings_file" ]]; then
        ${lib.getExe pkgs.jq} \
          '.attribution = { commit: "", pr: "", sessionUrl: false }' \
          "$settings_file" > "$settings_file.tmp"
      else
        printf '%s\n' '{"attribution":{"commit":"","pr":"","sessionUrl":false}}' > "$settings_file.tmp"
      fi

      mv "$settings_file.tmp" "$settings_file"
    fi
  '';

  # Claude stores MCP servers alongside mutable state in ~/.claude.json, so use its CLI to preserve unrelated settings.
  home.activation.claudeMcpServers = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if command -v claude >/dev/null 2>&1; then
      # Listing performs health checks, so cache the result before reconciling each server.
      registered_mcp_servers="$(claude mcp list 2>/dev/null)"
      ${lib.concatMapStringsSep "\n" removeMcpServer (builtins.attrNames mcpServers)}
      ${lib.concatStringsSep "\n" (lib.mapAttrsToList addMcpServer mcpServers)}
      unset registered_mcp_servers
    fi
  '';
}
