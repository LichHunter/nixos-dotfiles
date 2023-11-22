{ config, lib, pkgs, ... }:

let
  bar-name = "main-bar";
  background = "#1f1f1f";
  foreground = "#c6c6c6";
in {
  services.polybar = {
    enable = true;
    script = "polybar ${bar-name} &";
    package = pkgs.polybar.override {
      i3Support = true;
      i3 = pkgs.i3-gaps;
    };

    config = {
      "bar/${bar-name}" = {
        width = "100%";
        height = 27;
        radius = 0;
        fixed-center = true;
        background = "${background}";
        foreground = "${foreground}";

        line-size = 3;

        border-size = 0;

        padding-left = 0;
        padding-right = 2;

        module-margin-left = 1;
        module-margin-right = 2;

        font-0 = "Source Code Pro Semibold:size=10;1";
        font-1 = "Font Awesome 5 Free:style=Solid:size=10;1";
        font-2 = "Font Awesome 5 Brands:size=10;1";
        font-3 = "Font Awesome 5:size=13;0";

        modules-left = "wlan eth cpu memory";
        modules-center = "i3";
        modules-right = "battery date powermenu";

        tray-position = "right";
        tray-detached = false;
        tray-offset-x = 0;
        tray-offset-y = 0;
        tray-padding = 2;
        tray-maxsize = 20;
        tray-scale = 1;
        tray-background = "${background}";

        cursor-click = "pointer";
        cursor-scroll = "ns-resize";

        #separator = "|";
      };

      "module/i3" = {
        type = "internal/i3";
        format = "<label-state> <label-mode>";
        index-sort = true;
        wrapping-scroll = false;

        label-mode-padding = 2;
        label-mode-foreground = "#828282";
        label-mode-background = "${background}";

        label-focused = "%index%";
        label-focused-background = "#8abeb7";
        label-focused-foreground = "${background}";
        label-focused-padding = 2;

        label-unfocused = "%index%";
        label-unfocused-background = "#8abeb7";
        label-unfocused-foreground = "${background}";
        label-unfocused-padding = 2;

        label-visible = "%index%";
        label-visible-background = "#8abeb7";
        label-visible-foreground = "${background}";
        label-visible-padding = 2;

        label-urgent = "%index%";
        label-urgent-background = "${background}";
        label-urgent-padding = 2;
      };

      "module/wlan" = {
        type = "internal/network";
        interface = "net1";
        interval = "3.0";

        format-connected = "<ramp-signal> <label-connected>";
        format-connected-foreground = "#272827";
        format-connected-background = "#7E807E";
        format-connected-padding = 2;
        label-connected = "%essid%";

        ramp-signal-0 = "";
        ramp-signal-1 = "";
        ramp-signal-2 = "";
        ramp-signal-3 = "";
        ramp-signal-4 = "";
        ramp-signal-foreground = "#1f1f1f";
      };

      "module/eth" = {
        type = "internal/network";
        interface = "enp0s3";
        interval = "3.0";

        format-connected-padding = 2;
        format-connected-foreground = "#1f1f1f";
        format-connected-background = "#8abeb7";
        format-connected-prefix = " ";
        format-connected-prefix-foreground = "#1f1f1f";
        label-connected = "%local_ip%";
      };

      "module/date" = {
        type = "internal/date";
        interval = 5;

        date = "%Y-%m-%d";
        time = "%H:%M:%S";

        format-prefix = "  ";
        format-foreground = "#1f1f1f";
        format-background = "#8abeb7";
        format-padding = 2;

        label = "%time% %date%";
      };

      "module/powermenu" = {
        type = "custom/menu";

        expand-right = true;

        format-spacing = 1;

        label-open = "";
        label-open-foreground = "#8abeb7";
        label-close = " cancel";
        label-close-foreground = "#8abeb7";
        label-separator = "|";
        label-separator-foreground = "#8abeb7";

        menu-0-0 = "reboot";
        menu-0-0-exec = "menu-open-1";
        menu-0-1 = "power off";
        menu-0-1-exec = "menu-open-2";
        menu-0-2 = "log off";
        menu-0-2-exec = "menu-open-3";

        menu-1-0 = "cancel";
        menu-1-0-exec = "menu-open-0";
        menu-1-1 = "reboot";
        menu-1-1-exec = "reboot";

        menu-2-0 = "power off";
        menu-2-0-exec = "poweroff";
        menu-2-1 = "cancel";
        menu-2-1-exec = "menu-open-0";

        menu-3-0 = "log off";
        menu-3-0-exec = "i3 exit logout";
        menu-3-1 = "cancel";
        menu-3-1-exec = "menu-open-0";
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 1;
        label = " %percentage%%";
        format-foreground = "#1f1f1f";
        format-background = "#8abeb7";
      };

      "module/memory" = {
        type = "internal/memory";
        label = " %percentage_used%%";
        format-foreground = "#1f1f1f";
        format-background = "#8abeb7";
      };

      "module/battery" = {
        type = "internal/batter";
        # TODO add in future colors to the batter module
      };

      "settings" = {
        screenchange-reload = true;
      };

      "global/wm" = {
        margin-top = 0;
        margin-bottom = 0;
      };
    };
  };
}
