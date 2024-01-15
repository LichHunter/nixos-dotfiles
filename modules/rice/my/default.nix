{ config, lib, pkgs, ... }:

{
  imports = [
    ./hypr
    ./waybar
    ./gtk
  ];
}
