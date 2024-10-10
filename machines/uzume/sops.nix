{ config, lib, pkgs, inputs, username, ... }:

{
  imports = [
      inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    defaultSopsFile = ./secrets/secrets.yaml;
    validateSopsFiles = false;

    age = {
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      keyFile = "/var/lib/sops-nix/key.txt";
      generateKey = true;
    };

    secrets = {
      "wireguard-private-key" = {
        owner = config.users.users.${username}.name;
        inherit (config.users.users.${username}) group;
      };
    };
  };
}
