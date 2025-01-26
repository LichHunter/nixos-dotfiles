{ ... }:

{
  imports = [
    ./doas.nix
    ./docker.nix
    ./bluetooth.nix
    ./virtmanager.nix
    ./thunar.nix
    ./sddm.nix
    #./impermanence.nix
    ./services.nix
    ./i18n.nix
    ./networking.nix

    #services
    ./jellyfin.nix
    ./syncthing.nix
    ./printing.nix
    ./mpd.nix
    ./openssh.nix
    ./minecraft.nix

    #xserver
    ./hypr.nix
    ./plasma5.nix
    ./plasma6.nix
    ./i3.nix
    ./xmonad.nix
  ];
}
