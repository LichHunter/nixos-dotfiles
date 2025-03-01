{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dov.browser.vivaldi;
in {
  options.dov.browser.vivaldi.enable = mkEnableOption "vivaldi config";
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ vivaldi ];
  };
}
