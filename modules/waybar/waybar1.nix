{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    settings  =  {
      mainBar  =  {
         height = 30; # Waybar height (to be removed for auto height)
         spacing = 4; # Gaps between modules (4px)

         #Choose the order of the modules
         modules-left = ["hyprland/workspaces" "custom/waybarthemes"];
         modules-center = ["hyprland/window"];
         modules-right = ["mpd" "idle_inhibitor" "pulseaudio" "network" "cpu" "memory" "temperature" "backlight" "keyboard-state" "sway/language" "battery" "battery#bat2" "clock" "tray"];
         keyboard-state = {
             numlock = true;
             capslock = true;
             format = "{name} {icon}";
             format-icons = {
                 locked = "";
                 unlocked = "";
             };
         };
         #Waybar Themes
         "custom/waybarthemes" = {
             format = "Themes";
             on-click = "~/dotfiles/waybar/themeswitcher.sh";
             tooltip = false;
         };
         "sway/mode" = {
             format = "<span style=\"italic\">{}</span>";
         };
         "sway/scratchpad" = {
             format = "{icon} {count}";
             show-empty = false;
             format-icons = ["" ""];
             tooltip = true;
             tooltip-format = "{app}: {title}";
         };
         "mpd" = {
             format = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
             format-disconnected = "Disconnected ";
             format-stopped = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
             unknown-tag = "N/A";
             interval = 2;
             consume-icons = {
                 on = " ";
             };
             random-icons = {
                 off = "<span color=\"#f53c3c\"></span> ";
                 on = " ";
             };
             repeat-icons = {
                 on = " ";
             };
             single-icons = {
                 on = "1 ";
             };
             state-icons = {
                 paused = "";
                 playing = "";
             };
             tooltip-format = "MPD (connected)";
             tooltip-format-disconnected = "MPD (disconnected)";
         };
         "idle_inhibitor" = {
             format = "{icon}";
             format-icons = {
                 activated = "";
                 deactivated = "";
             };
         };
         "tray" = {
             spacing = 10;
         };
         "clock" = {
             tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
             format-alt = "{:%Y-%m-%d}";
         };
         "cpu" = {
             format = "{usage}% ";
             tooltip = false;
         };
         "memory" = {
             format = "{}% ";
         };
         "temperature" = {
             critical-threshold = 80;
             format = "{temperatureC}°C {icon}";
             format-icons = ["" "" ""];
         };
         "backlight" = {
             # device = "acpi_video1";
             format = "{percent}% {icon}";
             format-icons = ["" "" "" "" "" "" "" "" ""];
         };
         "battery" = {
             states = {
                 # good = 95;
                 warning = 30;
                 critical = 15;
             };
             format = "{capacity}% {icon}";
             format-charging = "{capacity}% ";
             format-plugged = "{capacity}% ";
             format-alt = "{time} {icon}";
             format-icons = ["" "" "" "" ""];
         };
         "network" = {
             # interface = "wlp2*"; // (Optional) To force the use of this interface
             format-wifi = "{essid} ({signalStrength}%) ";
             format-ethernet = "{ipaddr}/{cidr} ";
             tooltip-format = "{ifname} via {gwaddr} ";
             format-linked = "{ifname} (No IP) ";
             format-disconnected = "Disconnected ⚠";
             format-alt = "{ifname}: {ipaddr}/{cidr}";
         };
         "pulseaudio" = {
             # scroll-step = 1; // %; can be a float
             format = "{volume}% {icon} {format_source}";
             format-bluetooth = "{volume}% {icon} {format_source}";
             format-bluetooth-muted = " {icon} {format_source}";
             format-muted = " {format_source}";
             format-source = "{volume}% ";
             format-source-muted = "";
             format-icons = {
                 headphone = "";
                 hands-free = "";
                 headset = "";
                 phone = "";
                 portable = "";
                 car = "";
                 default = ["" "" ""];
             };
             on-click = "pavucontrol";
         };
         "custom/media" = {
             format = "{icon} {}";
             return-type = "json";
             max-length = 40;
             format-icons = {
                 spotify = "";
                 default = "🎜";
             };
             escape = true;
             exec = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null"; # Script in resources folder
         };
      };
    };

    style = lib.mkForce ./style.css;
  };
}
