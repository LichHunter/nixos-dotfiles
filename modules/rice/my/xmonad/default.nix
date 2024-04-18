{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
  ];
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;

    extraPackages = hp: [
      hp.dbus
      hp.monad-logger
      hp.xmonad-contrib
    ];
  };

  xdg = {
    enable = true;
    configFile = {
      "xmonad/xmonad.hs" = {
        source = ./xmonad.hs;
      };
    };
  };
}
