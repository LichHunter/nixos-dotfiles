{ config, lib, pkgs, ... }:

let
in {
  imports = [
    ./../variables.nix
  ];

  config.variables.username = "omen";
  config.variables.stateVersion = "23.11";
}
