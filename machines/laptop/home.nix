{ config, lib, pkgs, inputs, ... }:
let
  mod = "Mod4";

  colors = config.lib.stylix.colors;
in {
  imports = [
    ./variables.nix

    #default modules
    ./../../modules/git
    ./../../modules/alacritty
  ];

  home = {
    stateVersion = "${config.variables.stateVersion}";
    username = config.variables.username;
    homeDirectory = "/home/${config.variables.username}";
  };

  dov = {
    shell = {
      fish.enable = false;
      zsh.enable = true;
    };
    browser = {
      brave.enable = false;
      firefox.enable = true;
      chrome.enable = false;
    };
    hypr.enable = true;
    polybar.enable = false;
    kanshi.enable = true;
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

    # social
    telegram-desktop
    thunderbird
    signal-desktop

    # development
    gradle
    maven
    jetbrains.idea-ultimate
    jetbrains.webstorm
    direnv
    jdt-language-server
    yarn
    nodejs
    semgrep

    #torrent
    qbittorrent

    kate
    keepassxc
    virt-manager

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

  # blutooth applet
  services.blueman-applet.enable = true;

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
