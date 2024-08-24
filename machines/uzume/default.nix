{ inputs, pkgs, username, ... }:

let
in {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.home-manager
    ./disko-config.nix
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

  # Fixes for longhorn
  systemd.tmpfiles.rules = [
    "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
  ];
  virtualisation.docker = {
    enable = true;
    logDriver = "json-file";
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";
  # services.k3s = {
  #   enable = true;
  #   role = "server";
  #   tokenFile = /var/lib/rancher/k3s/server/token;
  #   extraFlags = toString ([
	#     "--write-kubeconfig-mode \"0644\""
	#     "--cluster-init"
	#     "--disable servicelb"
	#     "--disable traefik"
	#     "--disable local-storage"
  #   ] ++ (if meta.hostname == "homelab-0" then [] else [
	#       "--server https://homelab-0:6443"
  #   ]));
  #   clusterInit = (meta.hostname == "homelab-0");
  # };

  # services.openiscsi = {
  #   enable = true;
  #   name = "iqn.2016-04.com.open-iscsi:${meta.hostname}";
  # };

  security.pam = {
    sshAgentAuth.enable = true;
    services.sudo.sshAgentAuth = true;
  };

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
      vim
      jackett
    ];
    # Created using mkpasswd
    hashedPassword = "$6$oUcMXXTDVOSJw9y3$Y5oYAD9ogAUdkWQp30w/l43fupl2QLiwEt1mNWkl9ddGqsCgjMGNMvgUWiApxzFjIBlLWhZbKelZe01ROy5I8.";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBcGhVpjmWEw1GEw0y/ysJPa2v3+u/Rt/iES/Se2huH2 alexander0derevianko@gmail.com"
    ];
  };

  environment.systemPackages = with pkgs; [
     neovim
     k3s
     cifs-utils
     nfs-utils
     git
     jellyfin
     jellyfin-web
     jellyfin-ffmpeg
  ];

  networking.firewall.enable = false;

  services = {
    openssh.enable = true;

    jellyfin = {
      enable = true;
      openFirewall = true;
    };

    radarr = {
      enable = true;
      openFirewall = true;
    };
  };
}
