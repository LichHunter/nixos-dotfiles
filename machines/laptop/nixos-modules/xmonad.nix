{ config, lib, pkgs, ... }:

with lib;

{
  options.dov.xserver.xmonad.enable = mkEnableOption "xmonad configuration";
  config = mkIf config.dov.xserver.xmonad.enable {
    services.xserver = {
      enable = true;
      windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
#        config = ./xmonad.hs;
#        extraPackages = hp: [
#          hp.dbus
#          hp.monad-logger
#          hp.xmonad-contrib
#        ];
      };
    };
  };
}
