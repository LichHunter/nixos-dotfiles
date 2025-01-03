{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dov.notification.mako;
  colors = config.lib.stylix.colors;
in {
  options.dov.notification.mako.enable = mkEnableOption "mako configuration";

  config = mkIf cfg.enable {
    services.mako = {
     enable = true;
     backgroundColor = mkForce "#${colors.base01}";
     borderColor = mkForce "#${colors.base00}";
     borderRadius = 10;
     textColor = mkForce "#${colors.base0A}";

     defaultTimeout = 5000;
    };
  };
}
