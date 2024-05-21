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

      # Configs
      ".config/emacs"
      ".config/keepassxc"
      ".config/Element"
      ".config/qBittorrent"
      ".config/qutebrowser"
      ".config/mu4e"

      # Dot files
      ".mozilla" # need to make it more specific I think
      ".thunderbird"
      ".m2"
      ".java"
      ".gnupg"
      ".ssh"

      # Local/share
      ".local/share/keyrings"
      ".local/share/direnv"
      ".local/share/TelegramDesktop"
      ".local/share/Steam"
      ".local/share/lutris"
      ".local/share/qBittorrent"
      ".local/share/qutebrowser"
      ".local/share/docker/containers"
      ".local/share/docker/image"
      ".local/share/docker/volumes"
      ".local/share/docker/overlay2"

      # Cache
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
