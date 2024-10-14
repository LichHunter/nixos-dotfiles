{ config, lib, ... }:

with lib;

let
  cfg = config.nixarr.jellyfin;
  nixarr = config.nixarr;
in {
  options.nixarr.jellyfin = {
    enable = mkEnableOption "nixarr jellyfin config";
    stateDir = mkOption {
      type = types.path;
      default = "${nixarr.stateDir}/jellyfin";
      defaultText = literalExpression ''"''${nixarr.stateDir}/jellyfin"'';
      example = "/nixarr/.state/jellyfin";
      description = ''
        The location of the state directory for the Jellyfin service.

        > **Warning:** Setting this to any path, where the subpath is not
        > owned by root, will fail! For example:
        >
        > ```nix
        >   stateDir = /home/user/nixarr/.state/jellyfin
        > ```
        >
        > Is not supported, because `/home/user` is owned by `user`.
      '';
    };
  };

  config = mkIf cfg.enable {
    services.jellyfin = {
      enable = cfg.enable;
      group = "media";
      openFirewall = true;
      logDir = "${cfg.stateDir}/log";
      cacheDir = "${cfg.stateDir}/cache";
      dataDir = "${cfg.stateDir}/data";
      configDir = "${cfg.stateDir}/config";
      # TODO original nixarr also adds it to nginx
    };
  };
}
