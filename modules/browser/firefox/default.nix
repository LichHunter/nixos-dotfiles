{ lib, pkgs, config, ... }:

with lib;

let
  cfg = config.dov.browser.firefox;
in {
  config = mkIf cfg.enable {
    home.packages = [(pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true;}) {})];

    programs.firefox = {
      enable = true;
      arkenfox = {
        enable = true;
        version = "122.0";
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
          "0800".enable = true;
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
        };

        # bookmarks = [
        #   {
        #     name = "Google";
        #     tags = [ "google" ];
        #     keyword = "google";
        #     url = "https://google.com";
        #   }
        #   {
        #     name = "Appendix A. Home Manager Configuration Options";
        #     tags = [ "nixos" "home-manager" ];
        #     keyword = "appendix-a";
        #     url = "https://nix-community.github.io/home-manager/options.xhtml";
        #   }
        #   {
        #     name = "Advent code";
        #     tags = [];
        #     keyword = "adventcode";
        #     url = "https://adventofcode.com/";
        #   }
        #   {
        #     name = "Nixos Packages";
        #     tags = [ "nixos" ];
        #     keyword = "nixos";
        #     url = "https://search.nixos.org/packages";
        #   }
        #   {
        #     name = "Google Translate";
        #     tags = [ "google" ];
        #     keyword = "translate";
        #     url = "https://translate.google.com/";
        #   }
        #   {
        #     name = "YouTube";
        #     tags = [ "google" ];
        #     keyword = "youtube";
        #     url = "https://youtube.com";
        #   }
        #   {
        #     name = "Z-Library";
        #     tags = [ "z-lib" ];
        #     keyword = "z-lib";
        #     url = "https://singlelogin.re";
        #   }
        # ];

        search = {
          default = "Searxng Site (Searxng)";
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

            "Freesearch (Searxng)" = {
              urls = [{
                template = "https://freesearch.club/search";
                params = [
                  { name = "q"; value = "{searchTerms}"; }
                ];
              }];
              definedAleases = [ "@fsrx" ];
            };

            "Searxng Site (Searxng)" = {
              urls = [{
                template = "https://searxng.site/search";
                params = [
                  { name = "q"; value = "{searchTerms}"; }
                ];
              }];
              definedAleases = [ "@bsrx" ];
            };

            "Maven repository" = {
              urls = [{
                template = "https://mvnrepository.com/search?q={searchTerms}";
              }];

              definedAliases = [ "@mvn" ];
            };
          };
        };

        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          bitwarden
          keepassxc-browser
          darkreader
          cookie-autodelete
        ];
      };
    };
  };
}
