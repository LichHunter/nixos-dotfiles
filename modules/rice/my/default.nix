{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hypr
    ./waybar
    ./gtk
    ./packages.nix
  ];
}
