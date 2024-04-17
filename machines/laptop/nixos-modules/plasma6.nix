{ config, lib, pkgs, ... }:

with lib;

{
  options.dov.xserver.plasma6.enable = mkEnableOption "plasma config";
  config = mkIf config.dov.xserver.plasma6.enable {
    # services.xserver = {
    #   enable = true;
    #   displayManager.sddm.enable = true;
    # };
    # services.desktopManager.plasma6.enable = true;
  };
}
