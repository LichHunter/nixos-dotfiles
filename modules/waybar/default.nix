{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dov.hypr;
in {
  imports = [
    ./waybar4.nix
  ];


  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      waybar
    ];

    programs.waybar = {
      enable = true;
    };
  };
}
