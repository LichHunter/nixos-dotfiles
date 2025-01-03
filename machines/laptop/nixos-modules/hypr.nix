{ hyprland, config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dov.windowManager.hypr;
in{
  options.dov.windowManager.hypr.enable = mkEnableOption "hypr configuration";
  config = mkIf cfg.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
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
      graphics.enable = true;
      nvidia.modesetting.enable = true;
    };

    # For screen sharing
    services.pipewire.enable = true;
    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-wlr
          xdg-desktop-portal-gtk
          xdg-desktop-portal-gnome
          xdg-desktop-portal
        ];
      };
    };
  };
}
