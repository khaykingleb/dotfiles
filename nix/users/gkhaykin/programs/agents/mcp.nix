{ lib, pkgs }:
let
  keychainEnvironment = import ../../keychain-environment.nix { inherit pkgs; };

  /**
    Build a stdio MCP server configuration.

    Servers without secrets run directly. Servers with `secretVariables` run
    through the Keychain wrapper, which exports only those variables before
    starting `command` with `args`.

    # Type

    `mkStdioServer :: { command :: String, args ? [String], secretVariables ? [String], env ? AttrSet } -> AttrSet`
  */
  mkStdioServer =
    {
      command,
      args ? [ ],
      secretVariables ? [ ],
      env ? { },
    }:
    {
      type = "stdio";
      command = if secretVariables == [ ] then command else lib.getExe keychainEnvironment.package;
      args =
        if secretVariables == [ ] then
          args
        else
          secretVariables
          ++ [
            "--"
            command
          ]
          ++ args;
      inherit env;
    };

  httpMcpServers = {
    granola.url = "https://mcp.granola.ai/mcp";
    linear.url = "https://mcp.linear.app/mcp";
    notion.url = "https://mcp.notion.com/mcp";
  };

  stdioMcpServers = {
    grafana = mkStdioServer {
      command = lib.getExe pkgs.mcp-grafana;
      secretVariables = [ "GRAFANA_SERVICE_ACCOUNT_TOKEN" ];
      env.GRAFANA_URL = "https://togetherai.grafana.net";
    };
  };

  cursor = httpMcpServers // stdioMcpServers;
  claude = lib.mapAttrs (_: server: server // { type = "http"; }) httpMcpServers // stdioMcpServers;
in
{
  inherit cursor claude;
}
