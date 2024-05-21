{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    distrobox
  ];

  #xdg.configFile."distrobox/distrobox.conf".source = ./distrobox.conf;
}
