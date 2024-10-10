{ config, lib, pkgs, ... }:

{
  # enabling docker
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
