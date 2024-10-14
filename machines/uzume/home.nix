{ config, lib, pkgs, username, inputs, ... }:

{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
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
          nixos-build = "nixos-rebuild build --show-trace --flake ~/nixos-dotfiles#uzume";
          nixos-boot = "sudo nixos-rebuild boot --flake ~/nixos-dotfiles#uzume";
          nixos-switch = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#uzume";
          nixos-test = "sudo nixos-rebuild test --flake ~/nixos-dotfiles#uzume";
          sc = "source $HOME/.zshrc";
          psax = "ps ax | grep";
          cp = "rsync -ah --progress";
        };
      };

      addon.starship.enable = true;
    };
  };

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    eza
  ];
}
