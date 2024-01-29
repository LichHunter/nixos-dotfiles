{ config, lib, pkgs, ... }:

{
  programs.waybar = {
    settings = {
        # Workspaces
      "hyprland/workspaces" = {
          on-click = "activate";
          active-only = false;
          all-outputs = true;
          format = "{}";
          format-icons = {
            urgent = "";
            active = "";
            default = "";
          };
      };

      # Taskbar
      "wlr/taskbar" =  {
          format = "{icon}";
          icon-size = 18;
          tooltip-format = "{title}";
          on-click = "activate";
          on-click-middle = "close";
          ignore-list = ["Alacritty"];
          app_ids-mapping = {
              firefoxdeveloperedition = "firefox-developer-edition";
          };
          rewrite = {
              "Firefox Web Browser" = "Firefox";
              "Foot Server" = "Terminal";
          };
      };

      # Power Menu
      "custom/exit" = {
          format = "";
          on-click = "wlogout";
          tooltip = false;
      };

      # Keyboard State
      "keyboard-state" = {
          numlock = true;
          capslock = true;
          format = "{name} {icon}";
          format-icons = {
              locked = "";
              unlocked = "";
          };
      };

      # System tray
      "tray" = {
          # icon-size": 21;
          spacing = 10;
      };

      # Clock
      "clock" = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
      };

      # System
      "custom/system" = {
          format = "";
          tooltip = false;
      };

      # CPU
      "cpu" = {
          format = "/ C {usage}% ";
          on-click = "alacritty -e htop";
      };

      # Memory
      "memory" = {
          format = "/ M {}% ";
          on-click = "alacritty -e htop";
      };

      # Harddisc space used
      "disk" = {
          interval = 30;
          format = "D {percentage_used}% ";
          path = "/";
          on-click = "alacritty -e htop";
      };

      "hyprland/language" = {
          format = "/ K {short}";
      };

      # Group Hardware
      "group/hardware" = {
          orientation = "inherit";
          drawer = {
              transition-duration = 300;
              children-class = "not-memory";
              transition-left-to-right = false;
          };
          modules = [
              "custom/system"
              "disk"
              "cpu"
              "memory"
              "hyprland/language"
          ];
      };

      # Network
      "network" = {
          format = "{ifname}";
          format-wifi = "   {signalStrength}%";
          format-ethernet = "  {ipaddr}";
          format-disconnected = "Not connected"; #An empty format will hide the module.
          tooltip-format = " {ifname} via {gwaddri}";
          tooltip-format-wifi = "   {essid} ({signalStrength}%)";
          tooltip-format-ethernet = "  {ifname} ({ipaddr}/{cidr})";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
          on-click = "~/dotfiles/.settings/networkmanager.sh";
      };

      # Battery
      "battery" = {
          states = {
              # good = 95;
              warning = 30;
              critical = 15;
          };
          format = "{icon}   {capacity}%";
          format-charging = "  {capacity}%";
          format-plugged = "  {capacity}%";
          format-alt = "{icon}  {time}";
          format-icons = [" " " " " " " " " "];
      };

      # Pulseaudio
      "pulseaudio" = {
          format = "{icon} {volume}%";
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
              default = ["" " " " "];
          };
          on-click = "pavucontrol";
      };

      # Bluetooth
      "bluetooth" = {
          format = " {status}";
          format-disabled = "";
          format-off = "";
          interval = 30;
          on-click = "blueman-manager";
      };

      # Other
      "user" = {
          format = "{user}";
          interval = 60;
          icon = false;
      };

      "idle_inhibitor" = {
          format = "{icon}";
          tooltip = false;
          format-icons = {
              activated = "Auto lock OFF";
              deactivated = "ON";
          };
      };

    };
  };
}
