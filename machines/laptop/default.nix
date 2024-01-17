{ inputs, config, pkgs, stylix, extraHomeModules, nixos-hardware, nur, lib, ... }:

let
  theme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  wallpaper = pkgs.runCommand "image.png" {} ''
        COLOR=$(${pkgs.yq}/bin/yq -r .base00 ${theme})
        COLOR="#"$COLOR
        ${pkgs.imagemagick}/bin/magick convert -size 1920x1080 xc:$COLOR $out
  '';
in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./variables.nix
      ./hardware.nix
      ./doas.nix
      ./docker.nix
      ./bluetooth.nix
      ./virtmanager.nix
      ./thunar.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  system.stateVersion = "${config.variables.stateVersion}";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.wireless.iwd.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  services.xserver.enable = true;


  services.xserver = {
    layout = "us,ru";
    xkbOptions = "grp:grp:shifts_toggle";
  };

  services.printing.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users."${config.variables.username}" = {
    isNormalUser = true;
    description = "omen";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      kate
      keepassxc
      ripgrep
      fd
      virt-manager
      tor-browser

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
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim 
    wget
    git
    neovim
    base16-schemes
    htop
    brightnessctl
    networkmanagerapplet
    arandr
    zip
    unzip
    nvtop
    blueman
    killall
    # TODO move this to hypr config?
    pavucontrol
    pamixer
    # thunar plugin to manager archives
    xfce.thunar-archive-plugin
    async-profiler
    gparted

    # TODO move out to another file with other configs
    #hyprland packages
    waybar
    (pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      })
    )
    #eww
    mako
    libnotify
    kitty
    rofi-wayland
    wofi
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs = {
    zsh.enable = true;
    light.enable = true;
    nm-applet.enable = true;
    steam.enable = true;
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    emacs-all-the-icons-fonts
    font-awesome_5
    source-code-pro
  ];

  stylix = {
    image = wallpaper;

    # this can be used when we are using not base16 scheme but auto generated
    # to set dark colors as more prefered
    #polarity = "dark";
    base16Scheme = theme;

    fonts = {
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      monospace = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans Mono";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };

  dov = {
    xserver = {
      i3.enable = false;
      plasma.enable = false;
    };
    hypr.enable = true;
  };


  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users."${config.variables.username}" = {
    imports = [ ./home.nix

          inputs.nur.hmModules.nur
              ] ++ extraHomeModules;
    #dconf.settings."org/gnome/desktop/interface".font-name = lib.mkForce "JetBrainsMono Nerd Font 12";
  };


  # needed to fix swaylock not unlocking
  security.pam.services.swaylock = {};
}
