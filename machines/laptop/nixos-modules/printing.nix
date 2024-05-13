{ config, lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    libsForQt5.skanlite
    xsane
  ];

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };

  hardware.sane.enable = true; # enables support for SANE scanners
  users.users."omen".extraGroups = [ "scanner" "lp" ];
}
