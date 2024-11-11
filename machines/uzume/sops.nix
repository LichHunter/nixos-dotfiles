{ config, lib, pkgs, inputs, username, ... }:

{
  imports = [
      inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    validateSopsFiles = false;

    age = {
      # Moved keys to /var as from /home folder we are not able to access them on boot
      keyFile = "/var/lib/sops-nix/keys.txt";
      generateKey = false;
    };

    secrets = {
      "wireguard-private-key" = {
      };
      "gitlab-db-password" = {
        owner = config.users.users.${username}.name;
        inherit (config.users.users.${username}) group;
      };
      "gitlab-root-password" = {
        owner = config.users.users.${username}.name;
        inherit (config.users.users.${username}) group;
      };
      "gitlab-secret" = {
        owner = config.users.users.${username}.name;
        inherit (config.users.users.${username}) group;
      };
      "gitlab-otp-secret" = {
        owner = config.users.users.${username}.name;
        inherit (config.users.users.${username}) group;
      };
      "gitlab-db-secret" = {
        owner = config.users.users.${username}.name;
        inherit (config.users.users.${username}) group;
      };
      "nextcloud-password" = {
        owner = "nextcloud";
        group = "nextcloud";
      };
    };
  };
}
