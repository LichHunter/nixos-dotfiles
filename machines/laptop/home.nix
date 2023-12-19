{ config, lib, pkgs, ... }:
let
  mod = "Mod4";

  colors = config.lib.stylix.colors;
in {
  imports = [
    ./variables.nix
    ./../../modules/zsh
    ./../../modules/firefox
    ./../../modules/git
    ./../../modules/alacritty
  ];

  home = {
    stateVersion = "${config.variables.stateVersion}";
    username = config.variables.username;
    homeDirectory = "/home/${config.variables.username}";
  };

  dov = {
    fish.enable = false;
  };

  programs.home-manager.enable = true;

  services = {
    emacs.enable = true;
  };

  home.packages = with pkgs; [
    hello
    # if you enable gtk theames 
    # this is needed to fix "error: GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name ca.desrt.dconf was not provided by any .service files"
    dconf
    eza
    #i3
    dolphin
    picom
    nitrogen
    rxvt-unicode
    alsa-utils
    mate.mate-power-manager
    font-awesome_5
    source-code-pro

    # emacs
    ((pkgs.emacsPackagesFor pkgs.emacs28NativeComp).emacsWithPackages (epkgs: [
      epkgs.vterm
    ]))
    coreutils
    fd
    libtool
    ispell
    mu
    pandoc

    # social
    telegram-desktop

    # development
    maven
    jetbrains.idea-ultimate
    jetbrains.webstorm
    direnv
    jdt-language-server
  ];

  # fix collision between java17 and 11
  home.file."jdk/openjdk11".source = pkgs.jdk11;
  home.file."jdk/openjdk17".source = pkgs.jdk17;

  home.file."Wallpapers/wallpaper.png" = {
    source = ./wallpapers/wallpaper.png;
  };

  xdg = {
    enable = true;
    configFile = {
      "doom" = {
        source = ./doom-configs;
        recursive = true;
      };
    };
  };

  gtk = {
    enable = true;
    theme.name = "adw-gtk3";
    cursorTheme.name = "Bibata-Modern-Ice";
    iconTheme.name = "GruvboxPlus";
  };

  stylix = {
    autoEnable = true;
    targets.rofi.enable = true;
    targets.alacritty.enable = true;
  };

  # home.packages = with pkgs; [
  #   waybar
  #   swww
  # ];
  wayland.windowManager.hyprland = {
    enable = true;
    enableNvidiaPatches = true;
    extraConfig = ''

    # Monitor
    monitor=,highres,auto,1

    # Fix slow startup
    exec systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP

    # Autostart

    #exec-once = hyprctl setcursor Bibata-Modern-Classic 24
    #exec-once = dunst
    # TODO install nm-applet
    #exec-once = nm-applet

    source = /home/${config.variables.username}/.config/hypr/colors
    exec = pkill waybar & sleep 0.5 && waybar
    #exec-once = swww init & sleep 0.5 && exec wallpaper_random
    # exec-once = wallpaper_random

    # Set en layout at startup

    # Input config
    input {
        kb_layout = us,ru,ua
        kb_options = grp:grp:shifts_toggle

        follow_mouse = 1

        touchpad {
            natural_scroll = false
        }

        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
    }

    general {
        gaps_in = 5
        gaps_out = 20
        border_size = 2
        col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.inactive_border = rgba(595959aa)

        layout = dwindle
    }

    decoration {

        rounding = 10
        #blur = true
        #blur_size = 3
        #blur_passes = 1
        #blur_new_optimizations = true

        drop_shadow = true
        shadow_range = 4
        shadow_render_power = 3
        col.shadow = rgba(1a1a1aee)
    }

    animations {
        enabled = yes

        bezier = ease,0.4,0.02,0.21,1

        animation = windows, 1, 3.5, ease, slide
        animation = windowsOut, 1, 3.5, ease, slide
        animation = border, 1, 6, default
        animation = fade, 1, 3, ease
        animation = workspaces, 1, 3.5, ease
    }

    dwindle {
        pseudotile = yes
        preserve_split = yes
    }

    master {
        new_is_master = yes
    }

    gestures {
        workspace_swipe = false
    }

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

    $mainMod = SUPER
    bind = $mainMod, G, fullscreen,


    #bind = $mainMod, RETURN, exec, kitty
    bind = $mainMod, RETURN, exec, alacritty
    bind = SUPER_SHIFT, q, killactive,
    #bind = $mainMod, M, exit,
    bind = $mainMod, V, togglefloating,
    bind = $mainMod, p, exec, wofi --show drun

    # Switch Keyboard Layouts
    bind = $mainMod, SPACE, exec, hyprctl switchxkblayout teclado-gamer-husky-blizzard next

    bind = , Print, exec, grim -g "$(slurp)" - | wl-copy
    bind = SHIFT, Print, exec, grim -g "$(slurp)"

    # Functional keybinds
    bind =,XF86AudioMicMute,exec,pamixer --default-source -t
    bind =,XF86MonBrightnessDown,exec,brightnessctl s 20-
    bind =,XF86MonBrightnessUp,exec,brightnessctl s 20+
    bind =,XF86AudioMute,exec,amixer -q sset Master toggle
    bind =,XF86AudioLowerVolume,exec,amixer -q sset Master 10%-
    bind =,XF86AudioRaiseVolume,exec,amixer -q sset Master 10%+
    bind =,XF86AudioPlay,exec,playerctl play-pause
    bind =,XF86AudioPause,exec,playerctl play-pause

    # to switch between windows in a floating workspace
    bind = SUPER,Tab,cyclenext,
    bind = SUPER,Tab,bringactivetotop,

    # Move focus with mainMod + arrow keys
    bind = $mainMod, h, movefocus, l
    bind = $mainMod, l, movefocus, r
    bind = $mainMod, k, movefocus, u
    bind = $mainMod, j, movefocus, d

    # Switch workspaces with mainMod + [0-9]
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, workspace, 10

    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, 10

    # Scroll through existing workspaces with mainMod + scroll
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow
    bindm = ALT, mouse:272, resizewindow
        '';
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
