{ config, lib, username, ... }:

with lib;

let
  cfg = config.nixarr.deluge;
in {
  options.nixarr.deluge = {
    enable = mkEnableOption "nixarr deluge option";
  };

  config = mkIf cfg.enable {
    services.deluge = {
      enable = true;
      web = {
        enable = true;
        openFirewall = true;
      };
      declarative = false;

      group = "media";
      dataDir = "/data";

      authFile = /data/deluge/config/auth;

      config = {
        enabled_plugins = [ "Label" ];
        outgoing_interface = "wg0";
      };
    };
  };
}
