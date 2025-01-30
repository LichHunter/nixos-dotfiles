{ config, lib, pkgs, ... }:

{
  programs = {
    git = {
      enable = true;
      userName = "Alexander";
      userEmail = "alexander0derevianko@gmail.com";

      extraConfig = {
        safe = {
          directory = ["/home/omen/nixos-dotfiles" "/home/omen/.cache/nix"];
        };
      };
    };
  };
}
