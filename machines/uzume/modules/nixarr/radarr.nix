{ config, lib, ... }:

with lib;

let
  cfg = config.nixarr.radarr;
in {
  options.nixarr.radarr = {
    enable = mkEnableOption "nixarr radarr config";
    stateDir = mkOption {
      type = types.path;
      default = "${nixarr.stateDir}/radarr";
      defaultText = literalExpression ''"''${nixarr.stateDir}/radarr"'';
      example = "/nixarr/.state/radarr";
      description = ''
        The location of the state directory for the Radarr service.

        > **Warning:** Setting this to any path, where the subpath is not
        > owned by root, will fail! For example:
        >
        > ```nix
        >   stateDir = /home/user/nixarr/.state/radarr
        > ```
        >
        > Is not supported, because `/home/user` is owned by `user`.
      '';
    };
  };

  config = mkIf cfg.enable {
    services.radarr = {
      enable = cfg.enable;
      openFirewall = true;
      group = "media";

      # TODO add nginx like in original
    };
  };
}
