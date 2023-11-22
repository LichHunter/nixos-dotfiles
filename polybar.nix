{ config, lib, pkgs, ... }:

{
  services.polybar = {
    enable = true;
    script = "polybar i3wmthemer_bar &";
    extraConfig = ''
      [bar/i3wmthemer_bar]
      width = 100%
      height = 27
      radius = 0
      fixed-center = false

      background = #1f1f1f
      foreground = #c6c6c6

      line-size = 3
      line-color =

      border-size = 0
      border-color =

      padding-left = 0
      padding-right = 2

      module-margin-left = 1
      module-margin-right = 2

      font-0 = "Source Code Pro Semibold:size=10;1"
      font-1 = "Font Awesome 5 Free:style=Solid:size=10;1"
      font-2 = "Font Awesome 5 Brands:size=10;1"

      modules-left = wlan eth
      modules-center = i3
      modules-right = date powermenu

      tray-position =
      ;tray-padding =
      wm-restack = i3
      override-redirect = true

      cursor-click = pointer
      cursor-scroll = ns-resize

      [module/i3]
      type = internal/i3
      format = <label-state> <label-mode>
      index-sort = true
      wrapping-scroll = false

      label-mode-padding = 2
      label-mode-foreground = #828282
      label-mode-background = #1f1f1f

      label-focused = %index%
      label-focused-background = #8abeb7
      label-focused-foreground = #1f1f1f
      label-focused-padding = 2

      label-unfocused = %index%
      label-unfocused-background = #8abeb7
      label-unfocused-foreground = #1f1f1f
      label-unfocused-padding = 2

      label-visible = %index%
      label-visible-background = #8abeb7
      label-visible-foreground = #1f1f1f
      label-visible-padding = 2

      label-urgent = %index%
      label-urgent-background = #BA2922
      label-urgent-padding = 2

      [module/wlan]
      type = internal/network
      interface = net1
      interval = 3.0

      format-connected = <ramp-signal> <label-connected>
      format-connected-foreground = #272827
      format-connected-background = #7E807E
      format-connected-padding = 2
      label-connected = %essid%

      format-disconnected =

      ramp-signal-0 = 
      ramp-signal-1 = 
      ramp-signal-2 = 
      ramp-signal-3 = 
      ramp-signal-4 = 
      ramp-signal-foreground = #1f1f1f

      [module/eth]
      type = internal/network
      interface = enp0s3
      interval = 3.0

      format-connected-padding = 2
      format-connected-foreground = #1f1f1f
      format-connected-background = #8abeb7
      format-connected-prefix = " "
      format-connected-prefix-foreground = #1f1f1f
      label-connected = %local_ip%

      format-disconnected =

      [module/date]
      type = internal/date
      interval = 5

      date =
      date-alt = " %Y-%m-%d"

      time = %H:%M
      time-alt = %H:%M:%S

      format-prefix = 
      format-foreground = #1f1f1f
      format-background = #8abeb7
      format-padding = 2

      label = %date% %time%

      [module/powermenu]
      type = custom/menu

      expand-right = true

      format-spacing = 1

      label-open = 
      label-open-foreground = #8abeb7
      label-close =  cancel
      label-close-foreground = #8abeb7
      label-separator = |
      label-separator-foreground = #8abeb7

      menu-0-0 = reboot
      menu-0-0-exec = menu-open-1
      menu-0-1 = power off
      menu-0-1-exec = menu-open-2
      menu-0-2 = log off
      menu-0-2-exec = menu-open-3

      menu-1-0 = cancel
      menu-1-0-exec = menu-open-0
      menu-1-1 = reboot
      menu-1-1-exec = reboot

      menu-2-0 = power off
      menu-2-0-exec = poweroff
      menu-2-1 = cancel
      menu-2-1-exec = menu-open-0

      menu-3-0 = log off
      menu-3-0-exec = i3 exit logout
      menu-3-1 = cancel
      menu-3-1-exec = menu-open-0

      [settings]
      screenchange-reload = true

      [global/wm]
      margin-top = 0
      margin-bottom = 0
    '';
  };
}
