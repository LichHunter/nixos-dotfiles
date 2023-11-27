{ config, lib, pkgs, ... }:

{

  programs.zsh = {
    enable = true;
    history = {
      save = 10000;
    };

    shellAliases = {
      ll = "exa -al";
      nixos-build = "sudo nixos-rebuild build";
      nixos-switch = "sudo nixos-rebuild switch";
      sc = "source $HOME/.zshrc";
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
