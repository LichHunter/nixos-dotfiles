{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dov.shell.addon.starship;
in {
  options.dov.shell.addon.starship.enable = mkEnableOption "starship config";

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;

      settings = {
        nix_shell = {
          disabled = false;
          impure_msg = "";
          symbol = "";
          format = "[$symbol$state]($style) ";
        };
        shlvl = {
          disabled = false;
          symbol = "λ ";
        };
        haskell.symbol = " ";
        openstack.disabled = true;
        gcloud.disabled = true;
      };
    };
  };
}
