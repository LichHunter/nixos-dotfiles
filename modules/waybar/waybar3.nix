{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    settings = {
      mainBar = {
        layer = "top";
        margin-top = 0;
        margin-bottom = 0;
        margin-left = 0;
        margin-right = 0;
        spacing = 0;

        include = ["~/.config/waybar/modules.json"];

        modules-left = [
            "wlr/taskbar"
            "hyprland/window"
        ];

        modules-center = [
            "hyprland/workspaces"
        ];

        modules-right = [
            "pulseaudio"
            "bluetooth"
            "battery"
            "network"
            "idle_inhibitor"
            "custom/exit"
            "clock"
        ];
      };
    };

    style = lib.mkForce ./style3.css;
  };

  home.file.".config/waybar/modules.json".source = ./modules.json;
}
