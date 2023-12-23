{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dov.hypr;
  colors = config.lib.stylix.colors;
in {
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
