{ config, lib, pkgs, inputs, ... }:

{
  imports = [
      inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    validateSopsFiles = false;

    age = {
      keyFile = "/home/uzume/.config/sops/age/keys.txt";
      generateKey = false;
    };

    secrets = {
      wireguard-private-key = { };
    };
  };
}
