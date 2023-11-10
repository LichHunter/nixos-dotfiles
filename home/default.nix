{ config, pkgs, ... }:

let 
in {
  imports = [
    ./zsh   
    ./emacs
    ./alacritty
    ./git
    ./neovim
  ];
  
  xdg.enable = true;

  home.stateVersion = "23.05";
  home.username = "omen";
  home.homeDirectory = "/home/omen";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    firefox
    kate
    docker
    emacs-all-the-icons-fonts

    # nix related
    nix-output-monitor
  ];

  programs = {
    # Let home Manager install and manage itself.
    home-manager.enable = true;
  };

  services.emacs.enable = true;
}
