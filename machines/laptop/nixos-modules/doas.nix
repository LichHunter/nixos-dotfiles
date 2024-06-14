{ config, lib, pkgs, username, ... }:

{
  security = {
    sudo.enable = false;
    doas.enable = true;
    doas.extraRules = [{
      users = ["${username}"];
      keepEnv = true;  # Optional, retains environment variables while running commands
      persist = true;  # Optional, only require password verification a single time
    }];
  };
}
