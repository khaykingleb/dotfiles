{ pkgs, osConfig, ... }: {
  imports = [
    ./shared
  ] ++ (if osConfig.isDarwin or false
  then [ ./darwin ]
  else [ ./linux ]);
}
