{ config, lib, pkgs, ... }:

with lib;

{
  options.dov.windowManager.xmonad.enable = mkEnableOption "xmonad configuration";
  config = mkIf config.dov.windowManager.xmonad.enable {
    services.xserver = {
      enable = true;
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
      };
    };
  };
}
