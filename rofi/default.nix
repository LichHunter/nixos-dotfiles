{ config, lib, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    #theme = ./arc-dark.rasi;
  };
}
