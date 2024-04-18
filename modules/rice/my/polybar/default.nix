{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [ pulseaudioFull ];

  services = {
    polybar = {
      enable = true;
      #script = "polybar -q main -c \"~/.config/polybar/grayblocks/config.ini\" &";
      script = "polybar";
      package = pkgs.polybarFull;
    };
  };

  xdg = {
    enable = true;
    configFile = {
      "polybar/grayblocks" = {
        enable = false;
        source = ./grayblocks;
        recursive = true;
      };
      "polybar/config.ini" = {
        source = ./config.ini;
      };
      "polybar/scripts/pavolume.sh" = {
        source = ./scripts/pavolume.sh;
        executable = true;
      };
    };
  };
}
