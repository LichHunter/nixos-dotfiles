{ config, lib, pkgs, username, ... }:

with lib;

let
  cfg = config.nixarr;
in {
  config = mkIf cfg.vpn.enable {
    sops.secrets = {
      "wireguard-private-key" = {
        owner = config.users.users.${username}.name;
        inherit (config.users.users.${username}) group;
      };
    };

    networking = {
      wg-quick.interfaces.wg0 = {
        # IP address of this machine in the *tunnel network*
        address = [ "10.2.0.2/32" ];

        # To match firewall allowedUDPPorts (without this wg
        # uses random port numbers).
        listenPort = 51820;

        # Path to the private key file.
        privateKeyFile = cfg.vpn.wgConfig;

        peers = [
          {
            publicKey = "eqjhoqO6K1nLiej026+RkpSTHloVrOHLlMQaB0Tl5GM=";
            allowedIPs = [ "0.0.0.0/0" ];
            endpoint = "156.146.50.5:51820";
            persistentKeepalive = 25;
          }
        ];

        postUp = ''
          # Mark packets on the wg0 interface
          wg set wg0 fwmark 51820

          # Forbid anything else which doesn't go through wireguard VPN on
          # ipV4 and ipV6
          ${pkgs.iptables}/bin/iptables -A OUTPUT \
            ! -d 192.168.0.0/16 \
            ! -o wg0 \
            -m mark ! --mark $(wg show wg0 fwmark) \
            -m addrtype ! --dst-type LOCAL \
            -j REJECT
          ${pkgs.iptables}/bin/ip6tables -A OUTPUT \
            ! -o wg0 \
            -m mark ! --mark $(wg show wg0 fwmark) \
            -m addrtype ! --dst-type LOCAL \
            -j REJECT
        '';

        postDown = ''
          ${pkgs.iptables}/bin/iptables -D OUTPUT \
            ! -o wg0 \
            -m mark ! --mark $(wg show wg0 fwmark) \
            -m addrtype ! --dst-type LOCAL \
            -j REJECT
          ${pkgs.iptables}/bin/ip6tables -D OUTPUT \
            ! -o wg0 -m mark \
            ! --mark $(wg show wg0 fwmark) \
            -m addrtype ! --dst-type LOCAL \
            -j REJECT
        '';
      };
    };
  };
}
