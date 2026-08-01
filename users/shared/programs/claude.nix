# Claude Code global configuration
{ lib, ... }:
let
  mcpServers = (import ./agents/mcp-servers.nix { inherit lib; }).claude;

  /**
    Generates an activation-script fragment that adds an MCP server unless
    Claude already has a server with the same name.

    # Type

    ```
    addMcpServerIfMissing :: String -> AttrSet -> String
    ```
  */
  addMcpServerIfMissing = serverName: serverConfiguration: ''
    if ! claude mcp list 2>/dev/null | grep -q ${lib.escapeShellArg "^${serverName}:"}; then
      $DRY_RUN_CMD claude mcp add-json --scope user ${lib.escapeShellArg serverName} ${lib.escapeShellArg (builtins.toJSON serverConfiguration)} >/dev/null || true
    fi
  '';
in
{
  home.activation.claudeMcpServers = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if command -v claude >/dev/null 2>&1; then
      ${lib.concatStringsSep "\n" (lib.mapAttrsToList addMcpServerIfMissing mcpServers)}
    fi
  '';
}
