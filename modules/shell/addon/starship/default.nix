{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dov.shell.addon.starship;
in {
  programs.starship = {
    enable = cfg.enable;
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
}
