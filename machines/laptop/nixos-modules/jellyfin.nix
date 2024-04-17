{ config, lib, pkgs, ... }:

with lib;

{
  options.dov.services.jellyfin.enable = mkEnableOption "jellyfin config";
  config = mkIf config.dov.services.jellyfin.enable {
    environment.systemPackages = with pkgs; [
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ];

    services = {
      jellyfin = {
        enable = true;
      };
    };
  };
}
