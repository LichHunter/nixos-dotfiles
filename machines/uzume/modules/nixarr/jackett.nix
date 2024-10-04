{ config, lib, ... }:

with lib;

let
  cfg = config.nixarr.jackett;
in {
  options.nixarr.jackett = {
    enable = mkEnableOption "nixarr jackett config";
  };

  config = mkIf cfg.enable {
    services.jackett = {
      enable = cfg.enable;
      group = "media";
    };
  };
}
