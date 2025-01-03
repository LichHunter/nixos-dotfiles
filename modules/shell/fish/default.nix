{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dov.shell.fish;
in {
  options.dov.shell.fish.enable = mkEnableOption "fish config";

  config = mkIf cfg.enable {
      programs.fish = {
        enable = true;
      };
  };
}
