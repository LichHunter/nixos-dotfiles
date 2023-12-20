{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    settings = {
      mainBar = {
        include = [ "~/.config/waybar/config.json" ];

        layer = "top";
        position = "top";
        margin-top = 5;
        margin-bottom = 5;
        margin-left = 5;
        margin-right = 5;
        height = 30;

        modules-left = [
            # "custom/launcher"
            "hyprland/workspaces"
            "custom/media"
            "hyprland/window"
        ];

        modules-center = [
            "clock"
        ];

        modules-right = [
            "tray"
            # "idle_inhibitor"
            "memory"
            "cpu"
            # "custom/keyboard-layout"
            "backlight#value"
            "pulseaudio"
            "pulseaudio#microphone"
            "network"
            "battery"
        ];
      };
    };

    style = lib.mkForce ./style4.css;
  };

  home.file.".config/waybar/config.json".source = ./waybar4.json;
}
