{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dov.vpn;
in {
  options.dov.vpn.enable = mkEnableOption "vpn config";

  config = mkIf cfg.enable {
    home.packages = with pgks; [
      #vpn
      protonvpn-gui
      python311Packages.protonvpn-nm-lib
      protonvpn-cli
    ];
  };
}
