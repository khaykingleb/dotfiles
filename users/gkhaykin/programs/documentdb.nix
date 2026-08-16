{ pkgs }:
let
  caBundle = pkgs.fetchurl {
    url = "https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem";
    hash = "sha256-5bsghMz0UIe9ocm//eoOsV7mfwuRZGEG5GZxT53jx+M=";
  };

  endpoint = "documentdbqausw2.cluster-cli4qa266n3n.us-west-2.docdb.amazonaws.com";
in
pkgs.writeShellApplication {
  name = "documentdb-qa-mcp";
  runtimeInputs = [
    pkgs.awscli2
    pkgs.nodejs
    pkgs.ssm-session-manager-plugin
  ];
  text = ''
    if [[ -z "''${MDB_MCP_CONNECTION_STRING:-}" ]]; then
      echo "MDB_MCP_CONNECTION_STRING is required" >&2
      exit 1
    fi

    local_port="$(
      node <<'EOF'
    const net = require("node:net");
    const server = net.createServer();
    server.listen(0, "127.0.0.1", () => {
      process.stdout.write(String(server.address().port));
      server.close();
    });
    EOF
    )"

    tunnel_pid=
    mcp_pid=
    cleanup() {
      for pid in "$mcp_pid" "$tunnel_pid"; do
        if [[ -n "$pid" ]] && kill -0 "$pid" 2>/dev/null; then
          kill "$pid" 2>/dev/null || true
          wait "$pid" 2>/dev/null || true
        fi
      done
    }
    trap cleanup EXIT
    trap 'exit 130' INT
    trap 'exit 143' TERM

    aws ssm start-session \
      --profile together-qa-admin \
      --region us-west-2 \
      --target i-09da647eccd74ad64 \
      --document-name AWS-StartPortForwardingSessionToRemoteHost \
      --parameters "{\"host\":[\"${endpoint}\"],\"portNumber\":[\"27017\"],\"localPortNumber\":[\"$local_port\"]}" \
      </dev/null >&2 &
    tunnel_pid=$!

    DOCUMENTDB_LOCAL_PORT="$local_port" node <<'EOF'
    const net = require("node:net");
    const deadline = Date.now() + 10_000;
    const port = Number(process.env.DOCUMENTDB_LOCAL_PORT);

    function attempt() {
      const socket = net.createConnection({ host: "127.0.0.1", port });
      socket.once("connect", () => {
        socket.destroy();
        process.exit(0);
      });
      socket.once("error", () => {
        socket.destroy();
        if (Date.now() >= deadline) {
          console.error("Timed out waiting for the DocumentDB SSM tunnel");
          process.exit(1);
        }
        setTimeout(attempt, 100);
      });
    }

    attempt();
    EOF

    MDB_MCP_CONNECTION_STRING="$(
      DOCUMENTDB_LOCAL_PORT="$local_port" \
        DOCUMENTDB_CA_FILE="${caBundle}" \
        node <<'EOF'
    const connectionString = new URL(process.env.MDB_MCP_CONNECTION_STRING);

    connectionString.hostname = "127.0.0.1";
    connectionString.port = process.env.DOCUMENTDB_LOCAL_PORT;
    connectionString.searchParams.delete("readPreference");
    connectionString.searchParams.delete("replicaSet");
    connectionString.searchParams.delete("ssl");
    connectionString.searchParams.delete("tlsInsecure");
    connectionString.searchParams.set("directConnection", "true");
    connectionString.searchParams.set("tls", "true");
    connectionString.searchParams.set("tlsAllowInvalidHostnames", "true");
    connectionString.searchParams.set("tlsCAFile", process.env.DOCUMENTDB_CA_FILE);

    process.stdout.write(connectionString.toString());
    EOF
    )"
    export MDB_MCP_CONNECTION_STRING

    npx --yes mongodb-mcp-server@2.1.0 --readOnly &
    mcp_pid=$!
    wait "$mcp_pid"
  '';
}
