{ config, lib, ... }:

with lib;

let
  cfg = config.nixarr.sonarr;
  nixarr = config.nixarr;
in {
  options.nixarr.sonarr = {
    enable = mkEnableOption "nixarr sonarr config";
    stateDir = mkOption {
      type = types.path;
      default = "${nixarr.stateDir}/sonarr";
      defaultText = literalExpression ''"''${nixarr.stateDir}/sonarr"'';
      example = "/nixarr/.state/sonarr";
      description = ''
        The location of the state directory for the Sonarr service.

        > **Warning:** Setting this to any path, where the subpath is not
        > owned by root, will fail! For example:
        >
        > ```nix
        >   stateDir = /home/user/nixarr/.state/sonarr
        > ```
        >
        > Is not supported, because `/home/user` is owned by `user`.
      '';
    };
  };

  config = mkIf cfg.enable {
    services.sonarr = {
      enable = cfg.enable;
      openFirewall = true;
      group = "media";

      # TODO add nginx like in original
    };
  };
}
