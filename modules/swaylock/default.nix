{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    swayidle
  ];

  programs.swaylock = {
    enable = true;
    package = pkgs.swaylock-effects;
  };

  home.file.".config/swaylock/idle.sh".source = ./idle.sh;
  home.file.".config/swaylock/lock.sh".source = ./lock.sh;
}
