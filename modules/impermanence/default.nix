{ config, lib, pkgs, ... }:

{
  home.persistence."/persist/home" = {
    directories = [
      "Games"
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      "nixos-dotfiles"
      "org"
      "Code"
      ".config/emacs"
      ".mozilla" # need to make it more specific I think
      ".thunderbird"
      ".m2"
      ".java"
      ".gnupg"
      ".ssh"
      ".local/share/keyrings"
      ".local/share/direnv"
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }
    ];
    files = [
      ".screenrc"
      ".zsh_history"
    ];
    allowOther = true;
  };
}
