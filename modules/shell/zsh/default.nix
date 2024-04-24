{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.dov.shell.zsh;
in {
  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      history = {
        save = 10000;
      };

      initExtra = ''
        export JAVA_HOME=${pkgs.jdk17}
        export PATH=$PATH:$JAVA_HOME/bin
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

      plugins = [
        {
          # will source zsh-autosuggestions.plugin.zsh
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.0";
            sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
          };
        }
        {
          # will source zsh-autosuggestions.plugin.zsh
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "0.7.0";
            sha256 = "eRTk0o35QbPB9kOIV0iDwd0j5P/yewFFISVS/iEfP2g=";
          };
        }
      ];
      oh-my-zsh = {
        enable = true;
        theme = "bira";
        plugins = [ "git" "sudo" ];
      };
    };
  };
}
