{ config, lib, pkgs, ... }:

{

  programs.zsh = {
    enable = true;
    history = {
      save = 10000;
    };

    initExtra = ''
      export JAVA_HOME=${pkgs.jdk17}
      export PATH=$PATH:$JAVA_HOME/bin
    '';
      #export JDTLS_PATH=${pkgs.jdt-language-server}/share/java

    shellAliases = {
      ll = "exa -al";
      nixos-build = "sudo nixos-rebuild build";
      nixos-switch = "sudo nixos-rebuild switch";
      nixos-test = "sudo nixos-rebuild test";
      sc = "source $HOME/.zshrc";
      doom = "$HOME/.config/emacs/bin/doom";
      vim = "nvim";
      java17 = "export JAVA_HOME='/home/omen/jdk/openjdk17' && mvn -v";
      java11 = "export JAVA_HOME='/home/omen/jdk/openjdk11' && mvn -v";
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
}
