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
    #dolphin
    picom
    nitrogen
    rxvt-unicode
    alsa-utils
    mate.mate-power-manager
    font-awesome_5
    source-code-pro
    vlc

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

    #torrent
    qbittorrent

    #browsers
    brave
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
    autoEnable = true;
    targets.rofi.enable = true;
    targets.alacritty.enable = true;
  };

  # Enable autorandra for auto detection of connected displays
  programs.autorandr.enable = true;

  # blutooth applet
  services.blueman-applet.enable = true;

  dov = {
    polybar.enable = false;
  };

  # services.swayidle = {
  #   enable = true;

  #   events = [
  #     { event = "before-sleep"; command = "\"${pkgs.swaylock-effects}/bin/swaylock -f -F\""; }
  #     { event = "lock"; command = "\"${pkgs.swaylock-effects}/bin/swaylock -f -F\""; }
  #   ];

  #   timeouts = [
  #     { timeout = 60; command = "\"${pkgs.swaylock-effects}/bin/swaylock -f -F"; }
  #     #{ timeout = 90; command = "${pkgs.systemd}/bin/systemctl suspend"; }
  #   ];
  # };

  home.persistence."/persist/home" = {
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      "VirtualBox VMs"
      ".gnupg"
      ".ssh"
      ".nixops"
      ".local/share/keyrings"
      ".local/share/direnv"
      "nixos-dotfiles"
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
    ];
    files = [
      ".screenrc"
    ];
    allowOther = true;
  };
}
