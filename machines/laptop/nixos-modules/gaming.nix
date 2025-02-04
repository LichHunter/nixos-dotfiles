{ config, lib, pkgs, username, ... }:

with lib;

let
  cfg = config.dov.gaming.sunshine;
in {
  options.dov.gaming.sunshine.enable = mkEnableOption "sunshine streaming config";

  config = mkIf cfg.enable {
    users.users."${username}".packages = with pkgs; [
    ];

    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;

    };
    networking.firewall = {
      enable = true;
      allowedTCPPorts = [ 47984 47989 47990 48010 ];
      allowedUDPPortRanges = [
        { from = 47998; to = 48000; }
        { from = 8000; to = 8010; }
      ];
    };
  };
}
