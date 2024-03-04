{ hyprland, config, lib, pkgs, ... }:

with lib;
let
  cfg = config.dov.hypr;
in {

  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      # seems to be removed
      #nvidiaPatches = true;
      xwayland.enable = true;

      package = pkgs.hyprland.override {
        debug = true;
      };

    };

    environment = {
      systemPackages = with pkgs; [
        wlr-randr
        wdisplays
      ];

      sessionVariables = {
      WLR_NO_HARWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
      };
    };

    hardware = {
      opengl.enable = true;
      nvidia.modesetting.enable = true;
    };
  };
}
