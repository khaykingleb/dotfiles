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

  mkMongoDB = connectionStringReference: {
    type = "stdio";
    command = lib.getExe' pkgs.nodejs "npx";
    args = [
      "--yes"
      "mongodb-mcp-server@2.1.0"
      "--readOnly"
    ];
    env.MDB_MCP_CONNECTION_STRING = connectionStringReference;
  };

  mkDocumentDB = connectionStringReference: {
    type = "stdio";
    command = lib.getExe (import ../documentdb.nix { inherit pkgs; });
    env.MDB_MCP_CONNECTION_STRING = connectionStringReference;
  };

  cursor = {
    inherit linear notion;
    grafana = mkGrafana "\${env:GRAFANA_SERVICE_ACCOUNT_TOKEN}";
    mongodb-qa = mkDocumentDB "\${env:MONGODB_QA_CONNECTION_STRING}";
    mongodb-prod = mkMongoDB "\${env:MONGODB_PROD_CONNECTION_STRING}";
  };

  claude = {
    linear = linear // {
      type = "http";
    };
    notion = notion // {
      type = "http";
    };
    grafana = mkGrafana "\${GRAFANA_SERVICE_ACCOUNT_TOKEN}";
    mongodb-qa = mkDocumentDB "\${MONGODB_QA_CONNECTION_STRING}";
    mongodb-prod = mkMongoDB "\${MONGODB_PROD_CONNECTION_STRING}";
  };
in
{
  inherit cursor claude;
}
