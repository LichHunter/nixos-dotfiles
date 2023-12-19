{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dov.xserver.i3;
in {
  options.dov.xserver.i3.enable = mkEnableOption "i3 config";

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;

      windowManager.i3.enable = true;

      displayManager.sddm.enable = true;
      displayManager.defaultSession = "none+i3";
    };
  };
}
