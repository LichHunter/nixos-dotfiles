{ config, lib, pkgs, ... }:

{
  imports = [
    ../../variables.nix
  ];

  security = {
    sudo.enable = false;
    doas.enable = true;
    doas.extraRules = [{
      users = ["${config.variables.username}"];
      keepEnv = true;  # Optional, retains environment variables while running commands
      persist = true;  # Optional, only require password verification a single time
    }];
  };
}
