{ inputs, config, pkgs, stylix, extraHomeModules, nixos-hardware, lib, spkgs, username, ... }:

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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Warsaw";

  sound.enable = true;

  security.rtkit.enable = true;

  hardware = {
    pulseaudio.enable = false;
    xone.enable = true; #for xbox controller
    xpadneo.enable = true;
  };

  system = {
    stateVersion = "${config.variables.stateVersion}";
    userActivationScripts = {
      installDoomEmacs = ''
        if [ ! -d "$XDG_CONFIG_HOME/emacs" ]; then
            ${pkgs.git}/bin/git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
        fi
      '';
    };
  };

  users.users."${username}" = {
    isNormalUser = true;
    description = "My HP Omen laptop nixos";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
    shell = pkgs.zsh;
    #initialPassword = "test";
    #hashedPasswordFile = "/persist/hashedPassword";
    packages = with pkgs; [
      ## Emacs itself
      binutils       # native-comp needs 'as', provided by this
      # 28.2 + native-comp
      ((emacsPackagesFor emacs-unstable).emacsWithPackages
        (epkgs: [
          epkgs.vterm
          epkgs.treesit-grammars.with-all-grammars
          epkgs.mu4e
          epkgs.org-mime
        ]))

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
      # :lang nix
      nixfmt-classic
      # :lang lisp
      sbcl
      # :lang sh
      shellcheck
      # :lang typescript
      javascript-typescript-langserver
      deno
      # :lang go
      # go
      # gopls
      # gotests
      # gomodifytags
      # gore
      # gotools
      # :lang ruby
      ruby
      rbenv
      rubocop

      isync # mu4e related
    ];
  };

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
    nvtopPackages.full
    blueman
    killall
    # TODO move this to hypr config?
    pavucontrol
    pamixer
    async-profiler
    gparted
    distrobox

    # for lutris winetriks
    libsForQt5.kdialog
    cabextract
    libreoffice

    # backup
    pika-backup
  ];


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
  dov = {
    xserver = {
      i3.enable = false;
      plasma6.enable = false;
      hypr.enable = true;
      xmonad.enable = false;
      plasma5.enable = false;
    };

    services = {
      jellyfin.enable = false;
      syncthing.enable = true;
    };
  };

  fonts.packages = with pkgs; [
    nerdfonts
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


  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "home-backup";
    extraSpecialArgs = { inherit inputs spkgs username; };

    users."${username}" = {
      imports = [
        ./home.nix
        #inputs.impermanence.nixosModules.home-manager.impermanence
      ] ++ extraHomeModules;

      #dconf.settings."org/gnome/desktop/interface".font-name = lib.mkForce "JetBrainsMono Nerd Font 12";
    };
  };

  virtualisation.vmVariant = {
    # following configuration is added only when building VM with build-vm
    virtualisation = {
      memorySize =  8192; # Use 2048MiB memory.
      cores = 6;
    };
  };
}
