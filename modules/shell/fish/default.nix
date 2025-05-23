{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dov.shell.fish;
in {
  options.dov.shell.fish.enable = mkEnableOption "fish config";

  config = mkIf cfg.enable {
      programs.fish = {
        enable = true;
        shellAbbrs = {
          ll = "exa -al";
          nixos-build = "nixos-rebuild build --show-trace --flake ~/nixos-dotfiles#laptop";
          nixos-boot = "doas nixos-rebuild boot --flake ~/nixos-dotfiles#laptop";
          nixos-switch = "doas nixos-rebuild switch --flake ~/nixos-dotfiles#laptop";
          nixos-test = "doas nixos-rebuild test --flake ~/nixos-dotfiles#laptop";
          sc = "source $HOME/.zshrc";
          doom = "$HOME/.config/emacs/bin/doom";
          vim = "nvim";
          java23 = "export JAVA_HOME='/home/omen/jdk/openjdk23' && mvn -v";
          java21 = "export JAVA_HOME='/home/omen/jdk/openjdk21' && mvn -v";
          java17 = "export JAVA_HOME='/home/omen/jdk/openjdk17' && mvn -v";
          java11 = "export JAVA_HOME='/home/omen/jdk/openjdk11' && mvn -v";
          sudo = "doas";
          psax = "ps ax | grep";
          cp = "rsync -ah --progress";
        };
      };
  };
}
