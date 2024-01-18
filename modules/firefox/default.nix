{ lib, pkgs, ... }:

let
in {
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
          {
            name = "Google Translate";
            tags = [];
            keyword = "translate";
            url = "https://translate.google.com/";
          }
          {
            name = "youtube";
            tags = [ "google" ];
            keyword = "youtube";
            url = "https://youtube.com";
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

        extensions = (with pkgs.nur.repos.rycee.firefox-addons; [
          darkreader
          privacy-badger
          reddit-enhancement-suite
          ublock-origin
          https-everywhere
          multi-account-containers
          keepassxc-browser
          vimium
          octotree
          refined-github
          sponsorblock
          # pkgs.nur.repos.ethancedwards8.firefox-addons.enhancer-for-youtube
        ]);
      };
    };
  };


}
