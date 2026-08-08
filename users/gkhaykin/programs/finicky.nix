{ lib, pkgs, ... }:
lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
  # Home Manager has no default-browser option, so use duti (a macOS
  # LaunchServices CLI) to register Finicky as the HTTP(S) URL handler.
  home.packages = [ pkgs.duti ];
  home.file.".finicky.ts".source = ./finicky.ts;
  home.activation.setFinickyAsDefaultBrowser = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    run ${lib.getExe pkgs.duti} -s se.johnste.finicky http
  '';
}
