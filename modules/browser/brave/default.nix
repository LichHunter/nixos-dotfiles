{ config, lib, pkgs, ... }:
with lib;

let
  cfg = config.dov.browser.brave;
in {
  options.dov.browser.brave.enable = mkEnableOption "brave config";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ brave ];
  };
}
