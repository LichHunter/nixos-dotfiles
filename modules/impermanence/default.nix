{ config, lib, pkgs, ... }:

{
  home.persistence."/persist/home" = {
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      ".gnupg"
      ".ssh"
      ".local/share/keyrings"
      ".local/share/direnv"
      "nixos-dotfiles"
      ".config/emacs"
      "org"
      ".mozilla" # need to make it more specific I think
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
