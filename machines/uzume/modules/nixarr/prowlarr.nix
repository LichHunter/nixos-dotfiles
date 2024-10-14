{ config, lib, pkgs, ... }:

with lib;

let
  defaultPort = 9696;
  nixarr = config.nixarr;
  cfg = config.nixarr.prowlarr;
in {
  options.nixarr.prowlarr = {
    enable = mkEnableOption "nixarr prowlarr module";

    stateDir = mkOption {
      type = types.path;
      default = "${nixarr.stateDir}/prowlarr";
      defaultText = literalExpression ''"''${nixarr.stateDir}/prowlarr"'';
      example = "/nixarr/.state/prowlarr";
      description = ''
        The location of the state directory for the Prowlarr service.

        > **Warning:** Setting this to any path, where the subpath is not
        > owned by root, will fail! For example:
        >
        > ```nix
        >   stateDir = /home/user/nixarr/.state/prowlarr
        > ```
        >
        > Is not supported, because `/home/user` is owned by `user`.
      '';
    };
  };

  config = mkIf cfg.enable {
    services.prowlarr = {
      enable = true;
      openFirewall = true;
    };
  };
}
