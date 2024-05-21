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
      wlogout
    ];

    programs.waybar = {
      enable = true;
    };

    home.file.".config/waybar/change-waybar.sh" = {
      source = ./scripts/change-waybar.sh;
      executable = true;
    };
    home.file.".config/waybar/alt-1.sh" = {
      source = ./scripts/alt-1.sh;
      executable = true;
    };
    home.file.".config/waybar/default.sh" = {
      source = ./scripts/default.sh;
      executable = true;
    };

    home.file.".config/waybar/alt-1" = {
      recursive = true;
      source = ./alt-1;
    };
  };
}
