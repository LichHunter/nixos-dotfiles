{ config, lib, pkgs, ... }:

let
in {
  imports = [
    ./../variables.nix
  ];

  config.variables.username = "omen";
<<<<<<< HEAD
  config.variables.stateVersion = "23.11";
=======
  config.variables.stateVersion = "24.05";
>>>>>>> 24.05
}
