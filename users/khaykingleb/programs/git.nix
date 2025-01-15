# Version control system
{ config
, pkgs
, ...
}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Gleb Khaykin";
    userEmail = "khaykingleb@gmail.com";
  };
}
