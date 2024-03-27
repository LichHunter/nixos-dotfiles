{ config, lib, pkgs, ... }:

with lib;

#
# Application to auto manage displays on connection
#

let
  cfg = config.dov.kanshi;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ kanshi ];

    services.kanshi = {
      enable = true;
      profiles = {
        laptop = {
          outputs = [
            {
              criteria = "eDP-1";
            }
          ];
        };
        home = {
          outputs = [
            {
              criteria = "eDP-1";
              position = "480,1440";
            }
            {
              criteria = "LG Electronics LG ULTRAWIDE 201NTTQC5617";
              position = "0,0";
              mode = "3440x1440";
            }
          ];
        };
      };
    };
  };
}
