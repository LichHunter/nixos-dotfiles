{ ... }:

{
  imports = [
    ./doas.nix
    ./docker.nix
    ./bluetooth.nix
    ./virtmanager.nix
    ./thunar.nix
    ./sddm.nix
    ./impermanence.nix
    ./services.nix
    ./i18n.nix
    ./networking.nix
    ./jellyfin.nix
    ./syncthing.nix
  ];
}
