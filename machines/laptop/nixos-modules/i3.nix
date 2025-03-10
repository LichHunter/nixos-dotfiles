{ config, lib, pkgs, ... }:

with lib;

{
  options.dov.windowManager.i3.enable = mkEnableOption "i3 config";

  config = mkIf config.dov.windowManager.i3.enable {
    services.xserver = {
      enable = true;

      windowManager.i3.enable = true;

      displayManager.sddm.enable = true;
      displayManager.defaultSession = "none+i3";
    };
  };
}
