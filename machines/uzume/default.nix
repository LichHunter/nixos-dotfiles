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
    age.keyFile = "/home/${username}/.config/sops/age/keys.txt";

    secrets = {
      wireguard-private-key = {
        owner = config.users.users.${username}.name;
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
            image = "qmcgaw/gluetunl";
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

          # "deluge".service = {
          #   image = "dheaps/deluge";
          #   container_name = "deluge";
          #   restart="unless-stopped";
          #   network_mode = "container:gluetun-protonvpn";

          #   volumes = [
          #     "/home/${username}/deluge/data:/data"
          #     "/home/${username}/deluge/config:/config"
          #     "/etc/localtime:/etc/localtime:ro"
          #   ];

          #   environment = {
          #     UMASK="022";
          #     PUID="1000";
          #     PGID="100";
          #   };
          # };
        };
      };
    };
  };

  security.pam = {
    sshAgentAuth.enable = true;
    services.sudo.sshAgentAuth = true;
  };

  users.users.${username} = {
    name = username;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ]; # Enable ‘sudo’ for the user.
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

    jackett = {
      enable = true;
    };

    radarr = {
      enable = true;
      openFirewall = true;
    };
  };

  # nixarr = {
  #   enable = false;

  #   mediaDir = "/data/media";
  #   stateDir = "/data/media/.state/nixarr";

  #   vpn = {
  #     enable = true;
  #     wgConf = "/data/.secret/wg.conf";
  #   };

  #   jellyfin = {
  #     enable = true;
  #   };

  #   transmission = {
  #     enable = true;
  #     vpn.enable = true;
  #     peerPort = 50000; # Set this to the port forwarded by your VPN
  #   };

  #   radarr.enable = true;
  # };
}
