{ inputs, config, pkgs, stylix, extraHomeModules, nixos-hardware, lib, ... }:

let
  theme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  wallpaper = pkgs.runCommand "image.png" {} ''
        COLOR=$(${pkgs.yq}/bin/yq -r .base00 ${theme})
        COLOR="#"$COLOR
        ${pkgs.imagemagick}/bin/magick convert -size 1920x1080 xc:$COLOR $out
  '';
in {
  imports =
    [
      ./hardware-configuration.nix # Include the results of the hardware scan.
      ./variables.nix
      ./hardware
      ./nixos-modules
      inputs.home-manager.nixosModules.home-manager
    ];

  system.stateVersion = "${config.variables.stateVersion}";

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

  services.xserver.displayManager.sddm.enable = true;

  services.xserver.xkb = {
    layout = "us,ru";
    options = "grp:grp:shifts_toggle";
  };

  services.printing.enable = true;

  sound.enable = true;
  hardware = {
    pulseaudio.enable = false;
    xone.enable = true; #for xbox controller
    xpadneo.enable = true;
  };

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
    #initialPassword = "test";
    hashedPasswordFile = "/persist/hashedPassword";
    packages = with pkgs; [
      waybar

      ## Emacs itself
      binutils       # native-comp needs 'as', provided by this
      # 28.2 + native-comp
      ((emacsPackagesFor emacsNativeComp).emacsWithPackages
        (epkgs: [ epkgs.vterm ]))

      ## Doom dependencies
      git
      (ripgrep.override {withPCRE2 = true;})
      gnutls              # for TLS connectivity

      ## Optional dependencies
      fd                  # faster projectile indexing
      imagemagick         # for image-dired
      pinentry-emacs   # in-emacs gnupg prompts
      zstd                # for undo-fu-session/undo-tree compression

      ## Module dependencies
      # :checkers spell
      (aspellWithDicts (ds: with ds; [ en en-computers en-science ]))
      # :tools editorconfig
      editorconfig-core-c # per-project style config
      # :tools lookup & :lang org +roam
      sqlite
      # :lang latex & :lang org (latex previews)
      texlive.combined.scheme-medium
      # :lang beancount
      beancount
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    ripgrep
    fd
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
    p7zip
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
    #gnupg
    #pinentry

    # for lutris winetriks
    libsForQt5.kdialog
    cabextract
    libreoffice
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs = {
    zsh.enable = true;
    light.enable = true;
    nm-applet.enable = true;
    steam.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
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
    emacsPackages.all-the-icons
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
      plasma.enable = true;
    };
    hypr.enable = true;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs; };

    users."${config.variables.username}" = {
      imports = [
        ./home.nix
        inputs.impermanence.nixosModules.home-manager.impermanence
      ] ++ extraHomeModules;

      #dconf.settings."org/gnome/desktop/interface".font-name = lib.mkForce "JetBrainsMono Nerd Font 12";
    };
  };

  # needed to fix swaylock not unlocking
  security.pam.services.swaylock = {};

  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize =  8192; # Use 2048MiB memory.
      cores = 6;
    };
  };

  system.userActivationScripts = {
    installDoomEmacs = ''
      if [ ! -d "$XDG_CONFIG_HOME/emacs" ]; then
          ${pkgs.git}/bin/git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
      fi
    '';
  };
}
