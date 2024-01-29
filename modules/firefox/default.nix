{ lib, pkgs, ... }:

let
in {
  programs.firefox = {
    enable = true;
    arkenfox = {
      enable = true;
      version = "119.0";
    };

    profiles.Default = {
      arkenfox = {
        enable = true;
        # wiki page - https://arkenfox.dwarfmaster.net/
        "0000".enable = true;
        "0100".enable = true;
        "0200".enable = true;
        "0300".enable = true;
        "0400".enable = true;
        "0600".enable = true;
        "0700".enable = true;
        "0800".enable = false;
        "0900".enable = true;
        "1000".enable = true;
        "1200".enable = true;
        "1600".enable = true;
        "1700".enable = true;
        "2000".enable = false;
        "2400".enable = false; # dom related
        "2600".enable = false;
        "2700".enable = false;
        "2800".enable = false;
        "4500".enable = false; # RFP (resist fingerprinting)
        # "0001" = {
        #   enable = true;
        #   "0101"."browser.shell.checkDefaultBrowser".value = true;
        # };
        # "0002" = {
        #   enable = true;
        #   "0204"."browser.search.region".enable = true;
        # };
      };

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

      search = {
        default = "SearxNG";
        force = true;

        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                { name = "type"; value = "packages"; }
                { name = "query"; value = "{searchTerms}"; }
              ];
            }];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          "NixOS Wiki" = {
            urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
            iconUpdateURL = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@nw" ];
          };

          "Bing".metaData.hidden = true;
          "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias

          "SearxNG" = {
            urls = [{
              template = "https://freesearch.club/search";
              params = [
                { name = "q"; value = "{searchTerms}"; }
              ];
            }];
            definedAleases = [ "@srx" ];
          };
        };
      };

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
      ];
    };
  };
}
