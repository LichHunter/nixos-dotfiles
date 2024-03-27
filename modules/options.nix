{ config, lib, pkgs, ... }:

with lib;

let
in {
  options.dov.hypr.enable = mkEnableOption "hypr config";
  options.dov.kanshi.enable = mkEnableOption "hypr config";
}
