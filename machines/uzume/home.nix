{ config, lib, pkgs, username, ... }:

{
  imports = [
  ];

  home = {
    stateVersion = "24.05";
    username = username;
    homeDirectory = "/home/${username}";
  };

  dov = {
    shell = {
      zsh.enable = true;
    };
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
  ];

  programs.starship = {
    enable = false;
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
