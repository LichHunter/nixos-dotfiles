{ inputs, config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ];
  system.stateVersion = "23.05";

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      test = import ./home.nix;
    };
  };

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Warsaw";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  services.xserver = {
    enable = true;
    layout = "us";
    xkbVariant = "";

    windowManager.i3.enable = true;

    displayManager.sddm.enable = true;
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

  services = {
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  users.users.test = {
    isNormalUser = true;
    description = "test";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      firefox
      kate
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
     vim
     wget
     git
  ];

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
