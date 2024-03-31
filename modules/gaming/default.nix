{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dov.gaming;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Gaming
      steam
      wine
      (lutris.override {
        extraLibraries =  pkgs: [
          # List library dependencies here
        ];
        extraPkgs = pkgs: [
          # List package dependencies here
          wine
        ];
      })
      protontricks
    ];
  };
}
