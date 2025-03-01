{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dov.browser.ladybird;
in {
  options.dov.browser.ladybird.enable = mkEnableOption "ladybird config";

  config = mkIf cfg.enable {
    #home.packages = with pkgs; [ ladybird ];
  };
}
