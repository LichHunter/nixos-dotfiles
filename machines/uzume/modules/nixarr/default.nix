{ config, lib, pkgs, ... }:

with lib;

# based on https://github.com/rasmus-kirk/nixarr
let
  cfg = config.nixarr;
in {
  imports = [
    #./deluge.nix
    ./deluge_vpn.nix
    ./transmission.nix
    ./jackett.nix
    ./jellyfin.nix
    ./lidarr.nix
    ./radarr.nix
    ./sonarr.nix
    ./prowlarr.nix
    ./vpn.nix
  ];

  options.nixarr = {
    enable = mkEnableOption "nixarr config";
    user = mkOption {
      type = types.str;
    };
    vpn = {
      enable = mkEnableOption "nixarr vpn config";
      wgConfig = mkOption {
        type = types.nullOr types.path;
        default = null;
        example = "/data/.secret/vpn/wg.conf";
        description = ''
          Will enable vpn for whole system and all trafic will go through it
        '';
      };
    };
    mediaDir = mkOption {
      type = types.path;
      default = "/data/media";
      example = "/nixarr";
      description = ''
        The location of the media directory for the services.

        > **Warning:** Setting this to any path, where the subpath is not
        > owned by root, will fail! For example:
        >
        > ```nix
        >   mediaDir = /home/user/nixarr
        > ```
        >
        > Is not supported, because `/home/user` is owned by `user`.
      '';
    };

    stateDir = mkOption {
      type = types.path;
      default = "/data/.state/nixarr";
      example = "/nixarr/.state";
      description = ''
        The location of the state directory for the services.

        > **Warning:** Setting this to any path, where the subpath is not
        > owned by root, will fail! For example:
        >
        > ```nix
        >   stateDir = /home/user/nixarr/.state
        > ```
        >
        > Is not supported, because `/home/user` is owned by `user`.
      '';
    };
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.vpn.enable -> cfg.vpn.wgConfig != null;
        message = ''
          The nixarr.vpn.enable option requires the nixarr.vpn.wgConfig option
          to be set, but it was not.
        '';
      }
    ];
  };
}
