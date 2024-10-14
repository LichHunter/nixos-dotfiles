{ inputs, config, pkgs, username, extraHomeModules, ... }:

let
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager

    ./hardware-configuration.nix
    ./disko-config.nix
    ./sops.nix
    #./arion.nix
    ./services
    ./modules/nixarr
  ];

  system.stateVersion = "24.05";

  nix = {
    package = pkgs.nixFlakes;
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = username; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  security.pam = {
    sshAgentAuth.enable = true;
    services.sudo.sshAgentAuth = true;
  };

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "media" ];
    packages = with pkgs; [
      tree
      vim
    ];
    # Created using mkpasswd
    hashedPassword = "$6$oUcMXXTDVOSJw9y3$Y5oYAD9ogAUdkWQp30w/l43fupl2QLiwEt1mNWkl9ddGqsCgjMGNMvgUWiApxzFjIBlLWhZbKelZe01ROy5I8.";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBcGhVpjmWEw1GEw0y/ysJPa2v3+u/Rt/iES/Se2huH2 alexander0derevianko@gmail.com"
    ];

    shell = pkgs.zsh;
  };

  users.groups.media = { };

  environment.systemPackages = with pkgs; [
     neovim
     k3s
     cifs-utils
     nfs-utils
     git
     jellyfin
     jellyfin-web
     jellyfin-ffmpeg

     qbittorrent
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs username; };

    users."${username}" = {
      imports = [
        ./home.nix
      ] ++ extraHomeModules;
    };
  };

  networking.firewall.enable = false;

  services.openssh.enable = true;

  programs = {
    zsh.enable = true;
  };

  uzume = {
    gitlab.enable = false;
  };

  nixarr = {
    enable = true;
    vpn = {
      enable = false;
      wgConfig = config.sops.secrets.wireguard-private-key.path;
    };

    deluge.enable = true;
    jellyfin.enable = true;
    prowlarr.enable = true;
    radarr.enable = true;
    sonarr.enable = true;
    lidarr.enable = true;
  };
}
