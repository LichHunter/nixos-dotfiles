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
      zsh = {
        enable = true;
        shellAliases = {
          ll = "eza -al";
          nixos-build = "sudo nixos-rebuild build --show-trace --flake ~/nixos-dotfiles#uzume";
          nixos-boot = "sudo nixos-rebuild boot --flake ~/nixos-dotfiles#uzume";
          nixos-switch = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#uzume";
          nixos-test = "sudo nixos-rebuild test --flake ~/nixos-dotfiles#uzume";
          sc = "source $HOME/.zshrc";
          psax = "ps ax | grep";
          cp = "rsync -ah --progress";
        };
      };
    };
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    eza
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
