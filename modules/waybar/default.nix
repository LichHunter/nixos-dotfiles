{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    waybar
  ];

  programs.waybar = {
    enable = true;
    settings = {
        mainBar = {
            layer = "top";
            position = "top";
            height = 30;
            output = [ "eDP-1" ];

            modules-left = [ "disk" "memory" "cpu" "battery" ];
            modules-center = [ "hyprland/workspaces" ];
            modules-right = [ "clock" "tray" ];

            # TODO fix icons
            "hyprland/workspaces" =  {
                format = "<sub>{icon}</sub>";
                window-rewrite = {
                    "title<.*youtube.*>" = "";
                    "class<firefox>" = "";
                    "class<firefox> title<.*github.*>" = "";
                    };
            };

            "cpu" = {
                format = " {usage}%";
            };

            "battery" = {
                format = "{icon} {capacity}%";
                format-icons = ["" "" "" "" ""];
                interval = "60";
                states = {
                    warning = "30";
                    critical = "15";
                };
            };

            "memory" = {
                interval = "30";
                format = "{used}% ";
            };

            "disk" = {
                format = " {free}";
            };

            clock = {
                format = "{:%H:%M}  ";
                format-alt = "{:%A, %d %B, %Y (%R)}  ";
                tooltip-format = "<tt><small>{calendar}</small></tt>";
                calendar = {
                    mode = "year";
                    mode-mon-col = "3";
                    weeks-pos = "right";
                    on-scroll = "1";
                    on-click-right = "mode";
                    format = {
                        months =     "<span color='#ffead3'><b>{}</b></span>";
                        days =       "<span color='#ecc6d9'><b>{}</b></span>";
                        weeks =      "<span color='#99ffdd'><b>W{}</b></span>";
                        weekdays =   "<span color='#ffcc66'><b>{}</b></span>";
                        today =      "<span color='#ff6699'><b><u>{}</u></b></span>";
                    };
                };
                actions =  {
                    on-click-right = "mode";
                    on-click-forward = "tz_up";
                    on-click-backward = "tz_down";
                    on-scroll-up = "shift_up";
                    on-scroll-down = "shift_down";
                };
            };
        };
    };
  };
}
