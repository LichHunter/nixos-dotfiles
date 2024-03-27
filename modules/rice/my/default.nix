{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hypr
    ./waybar
    ./gtk
    ./i3
    ./packages.nix
  ];
}
