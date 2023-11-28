{ config, lib, pkgs, ... }:

{
  programs = {
    firefox = {
      enable = true;
      profiles.default = {
        bookmarks = [
          {
            name = "google";
            tags = [ "google" ];
            keyword = "google";
            url = "https://google.com";
          }
        ];
        settings = {
          "widget.use-xdg-desktop-portal.file-picker" = 1;
        };
      };
    };
  };
}
