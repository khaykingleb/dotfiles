{ lib, pkgs }:
let
  linear.url = "https://mcp.linear.app/mcp";
  notion.url = "https://mcp.notion.com/mcp";

  mkGrafana = tokenReference: {
    type = "stdio";
    command = lib.getExe pkgs.mcp-grafana;
    env = {
      GRAFANA_URL = "https://togetherai.grafana.net";
      GRAFANA_SERVICE_ACCOUNT_TOKEN = tokenReference;
    };
  };

  cursor = {
    inherit linear notion;
    grafana = mkGrafana "\${env:GRAFANA_SERVICE_ACCOUNT_TOKEN}";
  };

  claude = {
    linear = linear // {
      type = "http";
    };
    notion = notion // {
      type = "http";
    };
    grafana = mkGrafana "\${GRAFANA_SERVICE_ACCOUNT_TOKEN}";
  };
in
{
  inherit cursor claude;
}
