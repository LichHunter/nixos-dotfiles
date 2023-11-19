{ config, pkgs, ... }:
let
  mod = "Mod4";
  lib = pkgs.lib;
in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "test";
  home.homeDirectory = "/home/test";

  home.packages = with pkgs; [
    hello
    # if you enable gtk theames 
    # this is needed to fix "error: GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name ca.desrt.dconf was not provided by any .service files"
    dconf
    exa
    #i3
    #i3status-rust
    polybar
    rofi
    compton
    nitrogen
    rxvt-unicode
    alsa-utils
    mate.mate-power-manager
    font-awesome_5
    source-code-pro
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  programs.git = {
    enable = true;
    userName = "Alexander";
    userEmail = "alexander0derevianko@gmail.com";
  };

  gtk = {
    enable = true;
    theme.name = "adw-gtk3";
    cursorTheme.name = "Bibata-Modern-Ice";
    iconTheme.name = "GruvboxPlus";
  };

  programs.zsh = {
    enable = true;
    history = {
      save = 10000;
    };

    shellAliases = {
      ll = "exa -al";
      nixos-build = "sudo nixos-rebuild bild";
      nixos-switch = "sudo nixos-rebuild switch";
      sc = "source $HOME/.zshrc";
    };

    plugins = [
      {
        # will source zsh-autosuggestions.plugin.zsh
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.0";
          sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
        };
      }
      {
        # will source zsh-autosuggestions.plugin.zsh
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.7.0";
          sha256 = "eRTk0o35QbPB9kOIV0iDwd0j5P/yewFFISVS/iEfP2g=";
        };
      }
    ];
    oh-my-zsh = {
      enable = true;
      theme = "bira";
      plugins = [ "git" "sudo" ];
    };
  };

  programs.emacs = {
    enable = true;
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

  programs.rofi = {
    enable = true;
  };

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

  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = {
      modifier = mod;

      fonts = {
        names = ["xft:URWGothic-Book"];
        size = 11.0;
      };

      keybindings = lib.mkOptionDefault {
        "${mod}+p" = "exec ${pkgs.rofi}/bin/rofi -show run";
        "${mod}+x" = "exec sh -c '${pkgs.maim}/bin/maim -s | xclip -selection clipboard -t image/png'";
        "${mod}+Shift+x" = "exec sh -c '${pkgs.i3lock}/bin/i3lock -c 222222 & sleep 5 && xset dpms force of'";
        "${mod}+Return" = "exec konsole";

        # Focus
        "${mod}+j" = "focus left";
        "${mod}+k" = "focus down";
        "${mod}+l" = "focus up";
        "${mod}+semicolon" = "focus right";

        # Move
        "${mod}+Shift+j" = "move left";
        "${mod}+Shift+k" = "move down";
        "${mod}+Shift+l" = "move up";
        "${mod}+Shift+semicolon" = "move right";

        # My multi monitor setup
        "${mod}+m" = "move workspace to output DP-2";
        "${mod}+Shift+m" = "move workspace to output DP-5";

        "${mod}+u" = "border none";
        "${mod}+y" = "border pixel 1";
        "${mod}+n" = "border normal";

        "${mod}+h" = "split h;exec notify-send 'tile horizontally'";
        "${mod}+v" = "split v;exec notify-send 'tile vertically'";
        "${mod}+q" = "split toggle";
        "${mod}+f" = "fullscreen toggle";

        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";
        "${mod}+Shift+space" = "floating toggle";
      };

      startup = [
        {command = "nitrogen --restore; sleep 1; compoton -b"; notification = false;}
        {command = "nm-applet"; notification = false;}
        {command = "pkill polybar; sleep 1; polybar i3wmther_bar"; notification = false; always = true;}
      ];

       bars = [
         {
           position = "top";
           statusCommand = "${pkgs.polybar}/bin/polybar i3wmthemer_bar";
         }
       ];

      floating.criteria = [
        { title = "alsamixer"; }
        { title = "File Transfer*"; }
        { title = "i3_help"; }
        { class = "GParted"; }
        { class = "Lxappearence"; }
        { class = "Nitrogen"; }
      ];

      gaps = {
        inner = 10;
        outer = -4;
        smartGaps = true;
      };

      colors = {
        background = "#1f1f1f";
        focused = {
          border = "#c6c6c6";
          background = "#1f1f1f";
          text = "#c6c6c6";
          indicator = "#8abeb7";
          childBorder = "#8abeb7";
        };
        focusedInactive = {
          border = "#c6c6c6";
          background = "#1f1f1f";
          text = "#c6c6c6";
          indicator = "#8abeb7";
          childBorder = "#8abeb7";
        };
        unfocused = {
          border = "#c6c6c6";
          background = "#1f1f1f";
          text = "#c6c6c6";
          indicator = "#8abeb7";
          childBorder = "#8abeb7";
        };
        urgent = {
          border = "#c6c6c6";
          background = "#1f1f1f";
          text = "#c6c6c6";
          indicator = "#8abeb7";
          childBorder = "#8abeb7";
        };
        placeholder = {
          border = "#c6c6c6";
          background = "#1f1f1f";
          text = "#c6c6c6";
          indicator = "#8abeb7";
          childBorder = "#8abeb7";
        };
      };
    };
  };
}
