{ inputs, config, pkgs, username, extraHomeModules, ... }:

let
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager

    ./hardware-configuration.nix
    ./disko-config.nix
    ./sops.nix
    ./network.nix
    ./arion.nix
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

  virtualisation = {
    docker = {
      enable = true;
      logDriver = "json-file";
    };

    arion = {
      backend = "docker";
      projects = {
        "nginx".settings.services = {
          "nginx".service = {
            image = "jc21/nginx-proxy-manager:latest";
            restart = "unless-stopped";

            ports = [
              "80:80"
              "81:81"
              "443:443"
            ];

            volumes = [
              "/home/${username}/nginx/data:/data"
              "/home/${username}/nginx/letsencrypt:/etc/letsencrypt"
            ];

            environment = {
              PUID = "1000";
              PGID = "100";
            };
          };
        };
      };
    };
  };

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
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs username; };

    users."${username}" = {
      imports = [
        ./home.nix
        #inputs.impermanence.nixosModules.home-manager.impermanence
      ] ++ extraHomeModules;
    };
  };

  networking.firewall.enable = false;

  services = {
    openssh.enable = true;

    jellyfin = {
      enable = true;
      openFirewall = true;
      group = "media";
    };

    jackett = {
      enable = true;
      group = config.users.users.${username}.group;
    };

    radarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };

    sonarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };

    deluge = {
      enable = true;
      web.enable = true;
      declarative = true;

      group = "media";
      dataDir = "/data";

      authFile = /data/deluge/config/auth;

      config = {
        enabled_plugins = [ "Label" ];
        outgoing_interface = "wg0";
      };
    };
  };


  programs = {
    zsh.enable = true;
  };
}
