{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.dov.browser.brave;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ brave ];
  };
}
