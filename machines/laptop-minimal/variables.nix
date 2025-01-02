{ config, lib, pkgs, ... }:

let
in {
  imports = [
    ./../variables.nix
  ];

  config.variables.stateVersion = "24.11";
}
