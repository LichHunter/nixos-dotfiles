{ config, lib, pkgs, inputs, username, ... }:
let
  mod = "Mod4";

  colors = config.lib.stylix.colors;
in {
  imports = [
    ./variables.nix

    #default modules
    ./../../modules/git
    ./../../modules/alacritty
  ];

  home = {
    stateVersion = "${config.variables.stateVersion}";
    username = username;
    homeDirectory = "/home/${username}";
  };

  dov = {
    shell = {
      fish.enable = false;
      zsh = {
        enable = true;
        shellAliases = {
          ll = "exa -al";
          nixos-build = "nixos-rebuild build --show-trace --flake ~/nixos-dotfiles#laptop";
          nixos-boot = "sudo nixos-rebuild boot --flake ~/nixos-dotfiles#laptop";
          nixos-switch = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#laptop";
          nixos-test = "sudo nixos-rebuild test --flake ~/nixos-dotfiles#laptop";
          sc = "source $HOME/.zshrc";
          doom = "$HOME/.config/emacs/bin/doom";
          vim = "nvim";
          java21 = "export JAVA_HOME='/home/omen/jdk/openjdk21' && mvn -v";
          java17 = "export JAVA_HOME='/home/omen/jdk/openjdk17' && mvn -v";
          java11 = "export JAVA_HOME='/home/omen/jdk/openjdk11' && mvn -v";
          sudo = "doas";
          psax = "ps ax | grep";
          cp = "rsync -ah --progress";
        };
      };
    };
  };

  programs.home-manager.enable = true;
}
