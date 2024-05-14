{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dov.browser.chrome;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ chromium ];
  };
}
