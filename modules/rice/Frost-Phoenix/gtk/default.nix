{ pkgs, lib, ... }:
with lib;

{
  fonts.fontconfig.enable = true;
  home.packages = [
    pkgs.nerdfonts
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    pkgs.twemoji-color-font
    pkgs.noto-fonts-emoji
  ];

  gtk = {
    enable = true;
    font = {
      name = mkForce "JetBrainsMono Nerd Font";
      size = 12;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        flavor = "mocha";
        accent = "lavender";
      };
    };
    theme = {
      name = mkForce "Catppuccin-Mocha-Compact-Lavender-Dark";

      package = mkForce pkgs.catppuccin-gtk;
      # package = pkgs.catppuccin-gtk.override {
      #   accents = [ "lavender" ];
      #   size = "compact";
      #   # tweaks = [ "rimless" ];
      #   variant = "mocha";
      # };
    };
    cursorTheme = {
      name = "Nordzy-cursors";
      package = pkgs.nordzy-cursor-theme;
      size = 22;
    };
  };

  home.pointerCursor = lib.mkForce {
    name = "Nordzy-cursors";
    package = pkgs.nordzy-cursor-theme;
    size = 22;
  };
}
