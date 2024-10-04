{ config, lib, ... }:

with lib;

let
  cfg = config.nixarr.deluge;
in {
  options.nixarr.deluge = {
    enable = mkEnableOption "nixarr deluge option";
  };

  config = mkIf cfg.enable {
    services.deluge = {
      enable = cfg.enable;
      web.enable = true;
      declarative = true;

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
