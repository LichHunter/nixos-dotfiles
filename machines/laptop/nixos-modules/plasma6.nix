{ config, lib, pkgs, ... }:

with lib;

{
  options.dov.windowManager.plasma6.enable = mkEnableOption "plasma config";
  config = mkIf config.dov.windowManager.plasma6.enable {
    services.desktopManager.plasma6.enable = true;
  };
}
