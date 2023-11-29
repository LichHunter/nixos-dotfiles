{ config, lib, pkgs, ... }:

let
in {
  imports = [
    ./../variables.nix
  ];

  config.variables.username = "test";
  config.variables.stateVersion = "23.05";
}
