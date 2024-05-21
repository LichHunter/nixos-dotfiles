{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dov.shell.fish;
in {
  config = mkIf cfg.enable {
      programs.fish = {
        enable = true;
      };
  };
}
