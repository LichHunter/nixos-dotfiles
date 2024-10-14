{ config, lib, pkgs, inputs, username, ... }:

{
  imports = [
      inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    validateSopsFiles = false;

    age = {
      #sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/home/${username}/.config/sops/age/keys.txt";
      generateKey = false;

      # TODO this is propper way but it does not work and I need to copy key myself
      # keyFile = "/var/lib/sops-nix/key.txt";
      # generateKey = true;
    };

    secrets = {
      "wireguard-private-key" = {
      };
    };
  };
}
