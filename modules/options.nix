{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dov;
in {
  options.dov.xserver.hypr.enable = mkEnableOption "hypr config";
}
