{ config, lib, pkgs, username, ... }:

{
  virtualisation = {
    arion = {
      backend = "docker";
      projects = {
        "nginx".settings.services = {
          "nginx".service = {
            image = "jc21/nginx-proxy-manager:latest";
            restart = "unless-stopped";

            ports = [
              "8080:80"
              "8081:81"
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
}
