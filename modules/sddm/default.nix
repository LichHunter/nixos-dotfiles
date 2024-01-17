{ config, lib, pkgs, ... }:

{

  services.xserver.displayManager = {
    sddm = {
      enable = true;
      theme = "sugar-dark";
    };
  };

  environment.systemPackages = with pkgs; [
    #for sddm theme
    libsForQt5.qt5.qtquickcontrols2
    libsForQt5.qt5.qtgraphicaleffects

    (callPackage ./pkgs/sddm/sddm-theme.nix {}).sddm-sugar-dark
  ];
}
