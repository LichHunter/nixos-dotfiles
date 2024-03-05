{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dov.xserver.plasma6;
in {
  options.dov.xserver.plasma.enable = mkEnableOption "plasma6 config";

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;

      displayManager.sddm.enable = true;
      desktopManager.plasma6.enable = true;
    };
  };
}
