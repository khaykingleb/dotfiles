{ lib }:
let
  mcpServerDefinitions = {
    linear = {
      clients = [
        "claude"
        "cursor"
      ];
      url = "https://mcp.linear.app/mcp";
    };

    github = {
      clients = [
        "claude"
        "cursor"
      ];
      url = "https://api.githubcopilot.com/mcp/";
      headers.Authorization = {
        valuePrefix = "Bearer ";
        environmentVariable = "GITHUB_PERSONAL_ACCESS_TOKEN";
      };
    };

    notion = {
      clients = [
        "claude"
        "cursor"
      ];
      url = "https://mcp.notion.com/mcp";
    };

    grafana = {
      clients = [ "cursor" ];
      url = "https://mcp.grafana.com/mcp";
      headers.X-Grafana-URL.literalValue = "https://togetherai.grafana.net";
    };
  };

  /**
    Renders a literal header or an environment-variable reference using the
    syntax expected by the target client.

    # Type

    ```
    renderHeaderValue :: String -> AttrSet -> String
    ```
  */
  renderHeaderValue =
    clientName: headerDefinition:
    if headerDefinition ? environmentVariable then
      (headerDefinition.valuePrefix or "")
      + (
        if clientName == "cursor" then
          "\${env:${headerDefinition.environmentVariable}}"
        else
          "\${${headerDefinition.environmentVariable}}"
      )
    else
      headerDefinition.literalValue;

  /**
    Translates a shared MCP server definition into a client-specific configuration.

    # Type

    ```
    renderServerConfiguration :: String -> AttrSet -> AttrSet
    ```
  */
  renderServerConfiguration =
    clientName: serverDefinition:
    {
      inherit (serverDefinition) url;
    }
    // lib.optionalAttrs (clientName == "claude") {
      type = "http";
    }
    // lib.optionalAttrs (serverDefinition ? headers) {
      headers = lib.mapAttrs (_: renderHeaderValue clientName) serverDefinition.headers;
    };

  /**
    Selects and renders all MCP servers enabled for a client.

    # Type

    ```
    mcpServersForClient :: String -> AttrSet
    ```
  */
  mcpServersForClient =
    clientName:
    lib.mapAttrs (_: renderServerConfiguration clientName) (
      lib.filterAttrs (
        _: serverDefinition: lib.elem clientName serverDefinition.clients
      ) mcpServerDefinitions
    );
in
{
  claude = mcpServersForClient "claude";
  cursor = mcpServersForClient "cursor";
}
