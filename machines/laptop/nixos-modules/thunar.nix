{ config, lib, pkgs, ... }:

{
  # needed for thunar
  programs.thunar.enable = true;
  programs.xfconf.enable = true; # needed to save preferences
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
}
