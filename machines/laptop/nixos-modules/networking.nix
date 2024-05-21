{ config, lib, pkgs, ... }:

{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    wireless.iwd.enable = true;
    networkmanager.wifi.backend = "iwd";
  };
}
