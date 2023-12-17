{ config, lib, pkgs, ... }:

{
  programs = {
    firefox = {
      enable = true;
      profiles.default = {
	 extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          decentraleyes
          keepassxc-browser
          ublock-origin

          # # Missing:
          # cloudhole
          # devtools-adb-extension
          # firefox-sticky-window-containers
        ];
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
