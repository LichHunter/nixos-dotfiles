{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.nixarr.transmission;
  nixarr = config.nixarr;
  downloadDir = "${nixarr.mediaDir}/torrents";
in {
  options.nixarr.transmission = {
    enable = mkEnableOption "transmission config";

    stateDir = mkOption {
      type = types.path;
      default = "${nixarr.stateDir}/transmission";
      defaultText = literalExpression ''"''${nixarr.stateDir}/transmission"'';
      example = "/nixarr/.state/transmission";
      description = ''
        The location of the state directory for the Transmission service.

        > **Warning:** Setting this to any path, where the subpath is not
        > owned by root, will fail! For example:
        >
        > ```nix
        >   stateDir = /home/user/nixarr/.state/transmission
        > ```
        >
        > Is not supported, because `/home/user` is owned by `user`.
      '';
    };

    credentialsFile = mkOption {
      type = types.path;
      description = ''
        Path to a JSON file to be merged with the settings.
        Useful to merge a file which is better kept out of the Nix store
        to set secret config parameters like `rpc-password`.
      '';
      default = "/dev/null";
      example = "/var/lib/secrets/transmission/settings.json";
    };

    vpn.enable = mkOption {
      type = types.bool;
      default = false;
      example = true;
      description = ''
        **Required options:** [`nixarr.vpn.enable`](#nixarr.vpn.enable)

        Route Transmission traffic through the VPN.
      '';
    };

    flood.enable = mkEnableOption "the flood web-UI for the transmission web-UI.";

    peerPort = mkOption {
      type = types.port;
      default = 50000;
      example = 12345;
      description = "Transmission peer traffic port.";
    };

    uiPort = mkOption {
      type = types.port;
      default = 9091;
      example = 12345;
      description = "Transmission web-UI port.";
    };
  };

  config = mkIf cfg.enable {
    services.transmission = {
      enable = true;
      user = "torrenter";
      group = "media";
      home = cfg.stateDir;
      webHome =
        if cfg.flood.enable
        then pkgs.flood-for-transmission
        else null;
      package = pkgs.transmission_4;
      openRPCPort = true;
      openPeerPorts = true;
      credentialsFile = cfg.credentialsFile;
      settings =
        {
          download-dir = downloadDir;
          incomplete-dir-enabled = true;
          incomplete-dir = "${downloadDir}/.incomplete";
          watch-dir-enabled = true;
          watch-dir = "${downloadDir}/.watch";

          rpc-bind-address =
            if cfg.vpn.enable
            then "192.168.15.1"
            else "0.0.0.0";
          rpc-port = cfg.uiPort;
          rpc-whitelist-enabled = true;
          rpc-whitelist = strings.concatStringsSep "," ([
            "127.0.0.1,192.168.*,10.*" # Defaults
          ]);
          rpc-authentication-required = false;

          blocklist-enabled = true;
          blocklist-url = "https://github.com/Naunter/BT_BlockLists/raw/master/bt_blocklists.gz";

          peer-port = cfg.peerPort;
          utp-enabled = false;
          encryption = 1;
          port-forwarding-enabled = false;

          anti-brute-force-enabled = true;
          anti-brute-force-threshold = 10;

          message-level =
            if cfg.messageLevel == "none"
            then 0
            else if cfg.messageLevel == "critical"
            then 1
            else if cfg.messageLevel == "error"
            then 2
            else if cfg.messageLevel == "warn"
            then 3
            else if cfg.messageLevel == "info"
            then 4
            else if cfg.messageLevel == "debug"
            then 5
            else if cfg.messageLevel == "trace"
            then 6
            else null;
        };
    };

    # Enable and specify VPN namespace to confine service in.
    systemd.services.transmission.vpnconfinement = mkIf cfg.vpn.enable {
      enable = true;
      vpnnamespace = "wg";
    };

    # Port mappings
    vpnnamespaces.wg = mkIf cfg.vpn.enable {
      portMappings = [
        {
          from = cfg.uiPort;
          to = cfg.uiPort;
        }
      ];
      openVPNPorts = [
        {
          port = cfg.peerPort;
          protocol = "both";
        }
      ];
    };
  };
}
