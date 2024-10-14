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
    };
  };
}
