{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.uzume.nextcloud;
in {
  options.uzume.nextcloud.enable = mkEnableOption "nextcloud config";
  
  config = mkIf cfg.enable {
    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud30;
      hostName = "nextcloud.uzume-lab.duckdns.org";
      config.adminpassFile = config.sops.secrets.nextcloud-password.path;

      maxUploadSize = "1G";
    };
  };
}
