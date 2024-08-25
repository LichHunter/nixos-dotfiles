{ inputs, config, pkgs, username, ... }:

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

  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    defaultSopsFormat = "yaml";
    age = {
      keyFile = "/home/${username}/.config/sops/age/keys.txt";
    };

    secrets = {
      wireguard-private-key = {
        # TODO does not work for some reason, secret is still under root
        owner = config.users.users.${username}.name;
        group = config.users.users.${username}.group;
      };
    };
  };

  virtualisation = {
    docker = {
      enable = true;
      logDriver = "json-file";
    };

    arion = {
      backend = "docker";
      projects = {
        "deluge".settings.services = {
          "gluetun".service = {
            image = "qmcgaw/gluetun";
            container_name = "gluetun-protonvpn";
            capabilities = {
              NET_ADMIN = true;
            };
            environment = {
              VPN_SERVICE_PROVIDER="protonvpn";
              VPN_TYPE="wireguard";
              SERVER_COUNTRIES="Ukraine";
            };

            ports = [
              "8112:8112"
              "58846:58846"
              "58946:58946"
            ];

            volumes = [
              "${config.sops.secrets.wireguard-private-key.path}:/run/secrets/wireguard_private_key"
            ];
          };

          "deluge".service = {
            image = "dheaps/deluge";
            container_name = "deluge";
            restart="unless-stopped";
            network_mode = "container:gluetun-protonvpn";

            volumes = [
              "/home/${username}/deluge/data:/data"
              "/home/${username}/deluge/config:/config"
              "/etc/localtime:/etc/localtime:ro"
            ];

            environment = {
              UMASK="022";
            };
          };
        };

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

        # "media".settings.services = {
        #   "jellyfin".service = {
        #     image = "jellyfin/jellyfin";
        #     restart = "unless-stopped";
        #     container_name = "jellyfin";
        #     user = "0:0";

        #     ports = [
        #       "8096:8096"
        #     ];

        #     volumes = [
        #       "/data/jellyfin/config:/config"
        #       "/data/jellyfin/cache:/cache"
        #       "/data/media:/media"
        #       "/data/media2:/media2:ro"
        #     ];

        #     environment = {
        #       PUID = "0";
        #       PGID = "0";
        #     };
        #   };

        #   "radarr".service = {
        #     image = "lscr.io/linuxserver/radarr";
        #     restart = "unless-stopped";
        #     container_name = "radarr";

        #     ports = [
        #       "7878:7878"
        #     ];

        #     volumes = [
        #       "/data/radarr/data:/config"
        #       "/data/media/movies:/movies"
        #       "/data/incomplete:/incomplete"
        #     ];
        #   };
        # };
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

  networking.firewall.enable = false;

  services = {
    openssh.enable = true;

    # jellyfin = {
    #   enable = true;
    #   openFirewall = true;
    #   group = config.users.users.${username}.group;
    # };

    jackett = {
      enable = true;
      group = config.users.users.${username}.group;
    };

    radarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
  };
}
