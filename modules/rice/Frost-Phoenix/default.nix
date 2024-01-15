{ config, lib, pkgs, ... }:

{
  imports = [
    ./hyprland
    ./waybar
    ./gtk
  ];
}
