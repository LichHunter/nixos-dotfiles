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
      "syncthing"
      "Mail"
      ".config/emacs"
      ".config/keepassxc"
      ".config/Element"
      ".config/qBittorrent"
      ".config/qutebrowser"
      ".config/mu4e"
      ".mozilla" # need to make it more specific I think
      ".thunderbird"
      ".m2"
      ".java"
      ".gnupg"
      ".ssh"
      ".local/share/keyrings"
      ".local/share/direnv"
      ".local/share/TelegramDesktop"
      ".local/share/Steam"
      ".local/share/lutris"
      ".local/share/qBittorrent"
      ".local/share/qutebrowser"
      ".cache/keepassxc"
      ".cache/lutris"
    ];
    files = [
      ".screenrc"
      ".zsh_history"
      ".authinfo.gpg"
    ];
    allowOther = true;
  };
}
