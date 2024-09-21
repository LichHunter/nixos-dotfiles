{ config, lib, pkgs, username, ... }:

{
  imports = [
    ./gitea.nix
  ];

  services = {
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
}
