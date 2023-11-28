{ config, pkgs, ... }:
let
  mod = "Mod4";
  lib = pkgs.lib;
in {
  home = {
    stateVersion = "23.05";
    username = "test";
    homeDirectory = "/home/test";
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

    #emacs
    ((pkgs.emacsPackagesFor pkgs.emacs28NativeComp).emacsWithPackages (epkgs: [
      epkgs.vterm
    ]))
    coreutils
    fd
    libtool
    ispell
    mu
    pandoc
  ];

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
}
