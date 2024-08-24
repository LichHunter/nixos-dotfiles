{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dov.shell.bash;
in {
  config = mkIf cfg.enable {
    programs.bash = {
      enable = true;
      history = {
        save = 10000;
      };

      initExtra = ''
        export JAVA_HOME=${pkgs.jdk21}
        export PATH=$PATH:$JAVA_HOME/bin:$HOME/.npm-global
        export JDTLS_PATH=${pkgs.jdt-language-server}/share/java
      '';

      shellAliases = {
        ll = "exa -al";
        nixos-build = "sudo nixos-rebuild build --show-trace --flake ~/nixos-dotfiles#laptop";
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
}
