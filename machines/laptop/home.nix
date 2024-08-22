{ config, lib, pkgs, inputs, username, ... }:
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
    username = username;
    homeDirectory = "/home/${username}";
  };

  dov = {
    shell = {
      fish.enable = false;
      zsh.enable = true;
    };
    browser = {
      brave.enable = false;
      firefox.enable = true;
      chrome.enable = true;
      qutebrowser.enable = true;
      #vivaldi.enable = true;
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
    gcc

    coreutils
    libtool
    ispell
    mu
    pandoc
    python3

    # social
    telegram-desktop
    thunderbird
    element-desktop
    teams-for-linux

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
    devpod
    jetbrains.gateway
    tmux

    #torrent
    qbittorrent

    kate
    ark
    keepassxc
    virt-manager

    libreoffice
    grim
    slurp
    wl-clipboard
    qpdf
    cloudflared
    okular #pdf tool

    #music
    mpd
    mpv
    mpc-cli
    ncmpcpp
  ];

  # fix collision between java17 and 11
  home.file."jdk/openjdk11".source = pkgs.jdk11;
  home.file."jdk/openjdk17".source = pkgs.jdk17;
  home.file."jdk/openjdk21".source = pkgs.jdk21;

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
    enable = true;
    autoEnable = true;
    targets = {
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

  # TODO move to separate module
  programs.mbsync = {
    enable = true;
    extraConfig = ''
      IMAPStore alex-derevianko-remote
      Host imap.gmail.com
      SSLType IMAPS
      AuthMechs LOGIN
      User alexander0derevianko@gmail.com
      PassCmd "gpg -q --for-your-eyes-only --no-tty -d ~/.config/mu4e/mbsyncpass-acc-alex-derevianko.gpg"

      MaildirStore alex-derevianko-local
      Path ~/Mail/alex-derevianko/
      Inbox ~/Mail/alex-derevianko/INBOX
      Subfolders Verbatim

      Channel alex-derevianko
      Far :alex-derevianko-remote:
      Near :alex-derevianko-local:
      Create Both
      Expunge Both
      Patterns * !"[Gmail]/All Mail" !"[Gmail]/Bin" !"[Gmail]/Spam"
      SyncState *
    '';
  };


  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;

    settings = {
      nix_shell = {
        disabled = false;
        impure_msg = "";
        symbol = "";
        format = "[$symbol$state]($style) ";
      };
      shlvl = {
        disabled = false;
        symbol = "λ ";
      };
      haskell.symbol = " ";
      openstack.disabled = true;
      gcloud.disabled = true;
    };
  };
}
