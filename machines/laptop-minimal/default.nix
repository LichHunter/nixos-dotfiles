{ inputs, config, pkgs, extraHomeModules, spkgs, username, ... }:

let
  theme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  # wallpaper = pkgs.runCommand "~/Wallpapers/wallpaper.png" {} ''
  #       COLOR=$(${pkgs.yq}/bin/yq -r .base00 ${theme})
  #       COLOR="#"$COLOR
  #       ${pkgs.imagemagick}/bin/magick convert -size 1920x1080 xc:$COLOR $out
  # '';
in {
  imports =
    [
      ./hardware-configuration.nix # Include the results of the hardware scan.
      ./variables.nix
      ./disko-config.nix
      inputs.home-manager.nixosModules.home-manager
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Warsaw";

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
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" "audio" ];
    shell = pkgs.zsh;
    initialPassword = "test";
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
  ];


  programs = {
    zsh.enable = true;
    nm-applet.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
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

  networking.firewall.enable = true;
}
