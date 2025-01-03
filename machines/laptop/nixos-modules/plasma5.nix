{ config, lib, pkgs, ... }:

with lib;

{
  options.dov.windowManager.plasma5.enable = mkEnableOption "plasma5 config";
  config = mkIf config.dov.windowManager.plasma5.enable {
    services.xserver = {
      enable = true;
      displayManager.sddm.enable = true;
      desktopManager.plasma5.enable = true;
    };
  };
}
