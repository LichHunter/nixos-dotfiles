{ config, lib, pkgs, ... }:

with lib;

let
  #cfg = config.dov.fish;
in {
  options.dov.fish.enable = mkEnableOption "fish config";

  # we can replace "config.dov.fish" with "cfg" as we created it in let
  config = mkIf config.dov.fish.enable {
      programs.fish = {
        enable = true;
      };
  };
}
