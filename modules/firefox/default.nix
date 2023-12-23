{ config, lib, pkgs, ... }:

# TODO add config that duckduckgo will be search engine
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
          {
            name = "Appendix A. Home Manager Configuration Options";
            tags = [];
            keyword = "appendix-a";
            url = "https://nix-community.github.io/home-manager/options.xhtml";
          }
          {
            name = "Advent code";
            tags = [];
            keyword = "adventcode";
            url = "https://adventofcode.com/";
          }
          {
            name = "Nixos Packages";
            tags = [];
            keyword = "nixos";
            url = "https://search.nixos.org/packages";
          }
        ];

        settings = {
          "widget.use-xdg-desktop-portal.file-picker" = 1;
        };

        containers = {
          personal = {
            icon = "fingerprint";
            color = "blue";
            id = 1;
          };
          work = {
            icon = "briefcase";
            color = "orange";
            id = 2;
          };
        };

        # extenstions = with pkgs; [
        #   nur.repos.rycee.firefox-addons.privacy-badger
        # ];
      };
    };
  };
}
