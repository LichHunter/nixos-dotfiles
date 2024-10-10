{ lib, pkgs, config, ... }:

with lib;

let
  cfg = config.dov.browser.firefox;
in {
  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      package = (pkgs.wrapFirefox (pkgs.firefox-unwrapped.override { pipewireSupport = true;}) {});
      arkenfox = {
        enable = true;
        version = "128.0";
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

        search = {
          default = "Searx Work";
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

            "Searx Work" = {
              urls = [{
                template = "https://searx.work/search";
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
