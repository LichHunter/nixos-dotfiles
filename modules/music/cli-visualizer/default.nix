{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    cli-visualizer
  ];

  xdg.configFile."vis" = {
    source = ./configs;
    recursive = true;
  };
}
