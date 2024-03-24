{ config, lib, pkgs, inputs, ... }:

with lib;

let
  colors = config.lib.stylix.colors;
  cfg = config.dov.hypr;
in {
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      waybar
      swww
      mako
      pipewire
      wireplumber
      xdg-desktop-portal-hyprland

      #hyprland extensions
      hyprlock
      hypridle
    ];

    wayland.windowManager.hyprland = {
      enable = true;
      plugins = [
        #inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      ];

      settings = {
        monitor = ",highres,auto,1";
        source = "~/.config/hypr/colors";

        #Autostart
        exec = [
          # Fix slow startup
          "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "pkill waybar & sleep 0.5 && waybar"
        ];

        exec-once = [
          "mako"
          "polkit-kde-agent"
          "emacs --fg-daemon"
          "hypridle"
        ];

        "$mainMod" = "SUPER";

        bind = [
          "$mainMod, G, fullscreen,"

          #bind = $mainMod, RETURN, exec, kitty
          "$mainMod, RETURN, exec, alacritty"
          "$mainMod, o, exec, emacsclient -c"
          "SUPER_SHIFT, RETURN, exec, thunar"
          "SUPER_SHIFT, l, exec, hyprlock"

          #bind = $mainMod, M, exit,
          "SUPER_SHIFT, q, killactive,"
          "$mainMod, V, togglefloating,"
          "$mainMod, p, exec, wofi --show drun"

          # Switch Keyboard Layouts
          "$mainMod, SPACE, exec, hyprctl switchxkblayout teclado-gamer-husky-blizzard next"

          ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
          "SHIFT, Print, exec, IMG=~/Pictures/$(date +%Y-%m-%d_%H-%m-%s).png && grim -g \"$(slurp)\" $IMG"

          # Functional keybinds
          ",XF86AudioMicMute,exec,pamixer --default-source -t"
          ",XF86MonBrightnessDown,exec,brightnessctl s 20-"
          ",XF86MonBrightnessUp,exec,brightnessctl s 20+"
          ",XF86AudioMute,exec,amixer -q sset Master toggle"
          ",XF86AudioLowerVolume,exec,amixer -q sset Master 10%-"
          ",XF86AudioRaiseVolume,exec,amixer -q sset Master 10%+"
          ",XF86AudioPlay,exec,playerctl play-pause"
          ",XF86AudioPause,exec,playerctl play-pause"

          # to switch between windows in a floating workspace
          "SUPER,Tab,cyclenext,"
          "SUPER,Tab,bringactivetotop,"

          # Move focus with mainMod + arrow keys
          "$mainMod, h, movefocus, l"
          "$mainMod, l, movefocus, r"
          "$mainMod, k, movefocus, u"
          "$mainMod, j, movefocus, d"

          # Switch workspaces with mainMod + [0-9]
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
          "$mainMod,SPACE, exec, hyprctl switchxkblayout at-translated-set-2-keyboard next"
        ];

        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
          "ALT, mouse:272, resizewindow"
        ];

        input = {
          kb_layout = "us,ru,ua";
          kb_options = "grp:grp:shifts_toggle";

          follow_mouse = 1;

          touchpad = {
            natural_scroll = false;
          };

          sensitivity = 0;
        };

        general = {
          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;
          "col.active_border" = lib.mkForce "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = lib.mkForce "rgba(595959aa)";

          layout = "dwindle";
        };

        decoration = {
          rounding = 10;
          #blur = true
          #blur_size = 3
          #blur_passes = 1
          #blur_new_optimizations = true

          drop_shadow = true;
          shadow_range = 4;
          shadow_render_power = 3;
          "col.shadow" = lib.mkForce "rgba(1a1a1aee)";
        };

        animations = {
          enabled = "yes";

          bezier = "ease,0.4,0.02,0.21,1";

          animation = [
            "windows, 1, 3.5, ease, slide"
            "windowsOut, 1, 3.5, ease, slide"
            "border, 1, 6, default"
            "fade, 1, 3, ease"
            "workspaces, 1, 3.5, ease"
          ];
        };

        dwindle = {
          pseudotile = "yes";
          preserve_split = "yes";
        };

        master = {
          new_is_master = "yes";
        };

        gestures = {
          workspace_swipe = false;
        };


        # Example windowrule v1
        # windowrule = float, ^(kitty)$
        # Example windowrule v2
        # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

        #windowrule=float,^(kitty)$
        #windowrule=float,^(pavucontrol)$
        #windowrule=center,^(kitty)$
        #windowrule=float,^(blueman-manager)$
        #windowrule=size 600 500,^(kitty)$
        #windowrule=size 934 525,^(mpv)$
        #windowrule=float,^(mpv)$
        #windowrule=center,^(mpv)$
        ##windowrule=pin,^(firefox)$
      };
    };

    home.file.".config/hypr/colors".text = ''
      $background = ${colors.base00}
      $foreground = ${colors.base05}

      $color0 = ${colors.base00}
      $color1 = ${colors.base01}
      $color2 = ${colors.base02}
      $color3 = ${colors.base03}
      $color4 = ${colors.base04}
      $color5 = ${colors.base05}
      $color6 = ${colors.base06}
      $color7 = ${colors.base07}
      $color8 = ${colors.base08}
      $color9 = ${colors.base09}
      $color10 = ${colors.base0A}
      $color11 = ${colors.base0B}
      $color12 = ${colors.base0C}
      $color13 = ${colors.base0D}
      $color14 = ${colors.base0E}
      $color15 = ${colors.base0F}
    '';

    xdg.configFile."hypr/hyprlock.conf".source = ./hyprlock.conf;
    xdg.configFile."hypr/hypridle.conf".source = ./hypridle.conf;
  };
}
