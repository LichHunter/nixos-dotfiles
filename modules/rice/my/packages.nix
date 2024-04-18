{ config, lib, pkgs, ... }:

{
    home.packages = with pkgs; [
      yad
      feh
    ];
}
