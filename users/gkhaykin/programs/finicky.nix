{ lib, pkgs, ... }:
lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
  # Home Manager has no default-browser option, so use duti (a macOS
  # LaunchServices CLI) to register Finicky as the HTTP(S) URL handler.
  home.packages = [ pkgs.duti ];
  home.file.".finicky.ts" = {
    source = ./finicky.ts;

    # Finicky resolves the Home Manager symlink and watches its immutable
    # Nix-store target. Restart it when the symlink changes so it watches and
    # loads the new target.
    onChange = ''
      if [[ -v DRY_RUN ]]; then
        verboseEcho "Would restart Finicky to load its updated configuration"
      elif /usr/bin/pgrep -x Finicky >/dev/null; then
        /usr/bin/killall Finicky

        attempts=0
        while /usr/bin/pgrep -x Finicky >/dev/null && (( attempts < 50 )); do
          /bin/sleep 0.1
          (( attempts += 1 ))
        done

        if /usr/bin/pgrep -x Finicky >/dev/null; then
          echo "warning: Finicky did not stop; restart it manually to load the updated configuration" >&2
        else
          /usr/bin/open --env PATH=/usr/bin:/bin:/usr/sbin:/sbin -a Finicky
        fi
      fi
    '';
  };
  home.activation.setFinickyAsDefaultBrowser = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run ${lib.getExe pkgs.duti} -s se.johnste.finicky http
  '';
}
