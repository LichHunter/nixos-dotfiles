{ config, lib, pkgs, ... }:

{
  imports = [
    ./waybar4.nix
  ];

  home.packages = with pkgs; [
    waybar
  ];

  programs.waybar = {
    enable = true;
  };
}
