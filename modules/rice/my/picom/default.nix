{ config, lib, pkgs, ... }:

{
  services.picom = {
    enable = false;
  };

  xdg = {
    enable = true;
    configFile."picom/picom.conf" = {
      source = ./picom.conf;
    };
  };
}
