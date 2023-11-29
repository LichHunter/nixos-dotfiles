{ config, lib, pkgs, ... }:

{
  imports = [
    ./../variables.nix
  ];

  config.variables.username = "test";
}
