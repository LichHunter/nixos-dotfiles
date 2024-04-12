{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dov.xserver.plasma;
in {
  options.dov.xserver.plasma.enable = mkEnableOption "plasma config";

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
    };
  };
}
