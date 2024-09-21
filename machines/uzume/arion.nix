{ config, lib, pkgs, username, ... }:

{
  sops.secrets = {
    "wireguard-private-key" = {
      owner = config.users.users.${username}.name;
      inherit (config.users.users.${username}) group;
    };
  };

  virtualisation = {
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

        # "deluge".settings.services = {
        #   "gluetun".service = {
        #     image = "qmcgaw/gluetun";
        #     container_name = "gluetun-protonvpn";
        #     capabilities = {
        #       NET_ADMIN = true;
        #     };
        #     environment = {
        #       VPN_SERVICE_PROVIDER="protonvpn";
        #       VPN_TYPE="wireguard";
        #       SERVER_COUNTRIES="Ukraine";
        #     };
        #     ports = [
        #       "8112:8112"
        #       "58846:58846"
        #       "58946:58946"
        #     ];
        #     volumes = [
        #       "${config.sops.secrets.wireguard-private-key.path}:/run/secrets/wireguard_private_key"
        #     ];
        #   };
        #   "deluge".service = {
        #     image = "dheaps/deluge";
        #     container_name = "deluge";
        #     restart="unless-stopped";
        #     network_mode = "container:gluetun-protonvpn";
        #     volumes = [
        #       "/data:/data"
        #       "/data/deluge/config:/config"
        #       "/etc/localtime:/etc/localtime:ro"
        #     ];
        #     environment = {
        #       UMASK="022";
        #     };
        #   };
        # };
      };
    };
  };
}
