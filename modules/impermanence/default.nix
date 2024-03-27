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
      ".config/keepassxc"
      ".mozilla" # need to make it more specific I think
      ".thunderbird"
      ".m2"
      ".java"
      ".gnupg"
      ".ssh"
      ".local/share/keyrings"
      ".local/share/direnv"
      ".cache/keepassxc"
      ".cache/lutris"
      ".local/share/TelegramDesktop"
      ".local/share/Steam"
      ".local/share/lutris"
    ];
    files = [
      ".screenrc"
      ".zsh_history"
      ".authinfo.gpg"
    ];
    allowOther = true;
  };
}
