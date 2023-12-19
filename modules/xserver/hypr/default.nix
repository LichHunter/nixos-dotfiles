{ hyprland, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.dov.xserver.hypr;
in {
  options.dov.xserver.hypr.enable = mkEnableOption "hypr config";

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      # seems to be removed
      #nvidiaPatches = true;
      xwayland.enable = true;
    };

    environment.sessionVariables = {
      WLR_NO_HARWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };

    hardware = {
      opengl.enable = true;
      nvidia.modesetting.enable = true;
    };
    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };
}
