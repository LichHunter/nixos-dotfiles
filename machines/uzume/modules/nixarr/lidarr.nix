{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.nixarr.lidarr;
in {
  options.nixarr.lidarr = {
    enable = mkEnableOption "nixarr lidarr config";
    stateDir = mkOption {
      type = types.path;
      default = "${nixarr.stateDir}/lidarr";
      defaultText = literalExpression ''"''${nixarr.stateDir}/lidarr"'';
      example = "/nixarr/.state/lidarr";
      description = ''
        The location of the state directory for the Lidarr service.

        > **Warning:** Setting this to any path, where the subpath is not
        > owned by root, will fail! For example:
        >
        > ```nix
        >   stateDir = /home/user/nixarr/.state/lidarr
        > ```
        >
        > Is not supported, because `/home/user` is owned by `user`.
      '';
    };
  };

  config = mkIf cfg.enable {
    services.lidarr = {
      enable = cfg.enable;
      openFirewall = true;
      group = "media";
      dataDir = cfg.stateDir;

      # TODO add nginx like in original
    };
  };
}
