{ config, lib, pkgs, username, ... }:

{
  imports = [
    ./gitea.nix
    ./hydra.nix
  ];
}
