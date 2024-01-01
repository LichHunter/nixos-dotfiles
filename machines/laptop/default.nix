{ inputs, config, pkgs, stylix, extraHomeModules, nixos-hardware, nur, ... }:

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
      inputs.home-manager.nixosModules.home-manager
    ];

  system.stateVersion = "${config.variables.stateVersion}";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  # TODO network isn't conecting automatically
  networking.networkmanager.enable = true;

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

  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

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
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      kate
      keepassxc
      ripgrep
      fd
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
    nvtop
    blueman
    killall
    # TODO move this to hypr config?
    pavucontrol
    pamixer
    # thunar plugin to manager archives
    xfce.thunar-archive-plugin

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

    # Gaming
    steam
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs = {
    zsh.enable = true;
    light.enable = true;
    nm-applet.enable = true;
  };

  # needed for thunar
  programs.thunar.enable = true;
  programs.xfconf.enable = true; # needed to save preferences
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  
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
  };

  programs.steam = {
    enable = true;
  };

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  services.blueman.enable = true;
}
