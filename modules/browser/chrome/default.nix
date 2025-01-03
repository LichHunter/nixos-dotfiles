{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dov.browser.chrome;
in {
  options.dov.browser.chrome.enable = mkEnableOption "chrome config";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ chromium ];
  };
}
