{ config, lib, pkgs, ... }:

{
  services.lidarr = {
    enable = true;
    openFirewall = true;
    group = "media";
  };
}
