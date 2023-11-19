# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

let 

in {
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      test = import ./home.nix;
    };
  };

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
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

  services.xserver = {
    enable = true;
    #videoDrivers = [ "nvidia" ];
     
    #displayManager.lightdm.enable = true;
    displayManager.sddm.enable = true;
    #desktopManager.plasma5.enable = true;

    windowManager.i3.enable = true;
    displayManager.defaultSession = "none+i3";
    displayManager.sessionCommands = ''
      ${pkgs.xorg.xrdb}/bin/xrdb -merge <${pkgs.writeText "Xresources" ''
        *background:                      #1f1f1f
        *foreground:                      #c6c6c6
        *cursorColor:                     #c6c6c6

        *color0:                          #828282
        *color1:                          #cc6666
        *color2:                          #cc6666
        *color3:                          #f0c674
        *color4:                          #8abeb7
        *color5:                          #b294bb
        *color6:                          #8abeb7
        *color7:                          #828282
        *color8:                          #828282
        *color9:                          #cc6666
        *color10:                         #8abeb7
        *color11:                         #f0c674
        *color12:                         #8abeb7
        *color13:                         #b294bb
        *color14:                         #8abeb7
        *color15:                         #c6c6c6

        URxvt.font: xft:Source Code Pro:size=10.5
        URxvt.depth:                      32
        URxvt*scrollBar:                  false
        URxvt*mouseWheelScrollPage:       false
        URxvt*cursorBlink:                true
        URxvt*saveLines:                  5000
        URxvt*internalBorder: 5
        URxvt*geometry: 70x19

        rofi.color-enabled: true
        rofi.color-window: #828282, #8abeb7, #8abeb7
        rofi.color-normal: #828282, #c6c6c6, #8abeb7, #c6c6c6, #78824B
        rofi.color-active: #828282, #c6c6c6, #8abeb7, #c6c6c6, #78824B
        rofi.color-urgent: #828282, #c6c6c6, #8abeb7, #c6c6c6, #78824B

        rofi.separator-style: solid
        rofi.sidebar-mode: false
        rofi.lines: 5
        rofi.font: Source Code Pro Semibold 10.5
        rofi.bw: 1
        rofi.columns: 2
        rofi.padding: 5
        rofi.fixed-num-lines: true
        rofi.hide-scrollbar: true

        ! Normal copy-paste keybindings without perls
        URxvt.iso14755:                   false
        URxvt.keysym.Shift-Control-V:     eval:paste_clipboard
        URxvt.keysym.Shift-Control-C:     eval:selection_to_clipboard
        !Xterm escape codes, word by word movement
        URxvt.keysym.Control-Left:        \033[1;5D
        URxvt.keysym.Shift-Control-Left:  \033[1;6D
        URxvt.keysym.Control-Right:       \033[1;5C
        URxvt.keysym.Shift-Control-Right: \033[1;6C
        URxvt.keysym.Control-Up:          \033[1;5A
        URxvt.keysym.Shift-Control-Up:    \033[1;6A
        URxvt.keysym.Control-Down:        \033[1;5B
        URxvt.keysym.Shift-Control-Down:  \033[1;6B
      ''}
    '';

  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.test = {
    isNormalUser = true;
    description = "test";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      kate
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     git
     #my-package
  ];
 
  system.stateVersion = "23.05"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.zsh.enable = true;


  fonts.fonts = with pkgs; [
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
}
