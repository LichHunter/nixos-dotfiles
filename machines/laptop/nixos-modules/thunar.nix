{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # thunar plugin to manager archives
    xfce.thunar-archive-plugin
  ];
  # needed for thunar
  programs.thunar.enable = true;
  programs.xfconf.enable = true; # needed to save preferences
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
}
