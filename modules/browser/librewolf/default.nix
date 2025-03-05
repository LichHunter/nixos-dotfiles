{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dov.browser.librewolf;
in {
  options.dov.browser.librewolf.enable = mkEnableOption "librewolf config";

  config = mkIf cfg.enable {
    programs.librewolf.enable = true;
  };
}
