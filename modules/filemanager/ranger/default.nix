{ config, lib, pkgs, ... }:

{
  programs.ranger = {
    enable = true;
  };

  xdg = {
    enable = true;
    configFile = {
      "ranger/ranger_udisk_menu" = {
        source = builtins.fetchGit {
          url = "https://github.com/SL-RU/ranger_udisk_menu";
          rev = "c892d447177051dd2fa97e2387b2d04bf8977de7";
        };
      };
      "ranger/commands.py" = {
        source = ./commands.py;
      };
    };
  };
}
