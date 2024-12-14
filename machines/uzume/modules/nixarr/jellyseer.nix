{ config, lib, ... }:

with lib;

let
  cfg = config.nixarr.jellyfin.jellyseer;
in {
  options.nixarr.jellyfin.jellyseer = {
    enable = mkEnableOption "nixarr jellyfin jellyseer config";
    port = mkOption {
      type = types.int;
      default = 5055;
      example = "5055";
    };
  };
  config = mkIf cfg.enable {
    services.jellyseerr = {
      enable = true;
      port = cfg.port;
      openFirewall = true;
    };
  };
}
