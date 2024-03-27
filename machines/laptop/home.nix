{ config, lib, pkgs, inputs, ... }:
let
  mod = "Mod4";

  colors = config.lib.stylix.colors;
in {
  imports = [
    ./variables.nix

    #default modules
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
    hypr.enable = true;
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    hello
    # if you enable gtk theames 
    # this is needed to fix "error: GDBus.Error:org.freedesktop.DBus.Error.ServiceUnknown: The name ca.desrt.dconf was not provided by any .service files"
    dconf
    eza
    picom
    nitrogen
    rxvt-unicode
    alsa-utils
    mate.mate-power-manager
    font-awesome_5
    source-code-pro
    vlc

    coreutils
    libtool
    ispell
    mu
    pandoc
    python3
    gradle

    # social
    telegram-desktop
    thunderbird

    # development
    maven
    jetbrains.idea-ultimate
    jetbrains.webstorm
    direnv
    jdt-language-server

    #torrent
    qbittorrent

    #browsers
    brave
    firefox
    tor-browser

    #eww
    mako
    libnotify
    kitty
    rofi-wayland
    wofi

    kate
    keepassxc
    virt-manager

    # Gaming
    steam
    wine
    (lutris.override {
      extraLibraries =  pkgs: [
        # List library dependencies here
      ];
      extraPkgs = pkgs: [
        # List package dependencies here
        wine
      ];
    })
    protontricks

    #vpn
    protonvpn-gui
    python311Packages.protonvpn-nm-lib
    protonvpn-cli

    #libsForQt5.spectacle
    #flameshot

    libreoffice
    grim
    slurp
    wl-clipboard

    qpdf
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

  stylix = {
    autoEnable = false;
    targets = {
      rofi.enable = true;
      alacritty.enable = true;
      #wofi.enable = true;
      firefox.enable = true;
      gtk.enable = true;
      hyprland.enable = true;
      kde.enable = false;
    };
  };

  # Enable autorandra for auto detection of connected displays
  programs.autorandr = {
    enable = false;
    profiles = {
      "work" = {
        fingerprint = {
          eDP1 = "<EDID>";
          DP1 = "<EDID>";
        };
        config = {
          eDP1.enable = false;
          DP1 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "3840x2160";
            gamma = "1.0:0.909:0.833";
            rate = "60.00";
            rotate = "left";
          };
        };
      };
    };
  };

  # blutooth applet
  services.blueman-applet.enable = true;

  dov = {
    polybar.enable = false;
  };


  xdg.mimeApps = {
      enable = true;
      defaultApplications = {
          "default-web-browser" = [ "firefox.desktop" ];
          "text/html" = [ "firefox.desktop" ];
          "x-scheme-handler/http" = [ "firefox.desktop" ];
          "x-scheme-handler/https" = [ "firefox.desktop" ];
          "x-scheme-handler/about" = [ "firefox.desktop" ];
          "x-scheme-handler/unknown" = [ "firefox.desktop" ];
      };
  };
}
