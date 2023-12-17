{ hyprland, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.dov.xserver.hypr;
in {
  options.dov.xserver.hypr.enable = mkEnableOption "hypr config";

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      package = hyprland.packages.${pkgs.system}.hyprland;
    };
  };
}
