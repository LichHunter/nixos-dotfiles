{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
    emacs-overlay.url = "github:nix-community/emacs-overlay/master";
    hyprland.url = "github:hyprwm/Hyprland";
    nur.url = "github:nix-community/NUR";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, stylix, nixos-hardware, emacs-overlay, hyprland, nur, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
      overlays = [
        emacs-overlay.overlay
      ];
    };

    defaultNixOptions = {
      nix.settings.auto-optimise-store = true;
    };

    mkComputer = configurationNix: extraModules: extraHomeModules: inputs.nixpkgs.lib.nixosSystem {
      inherit system ;
      specialArgs = { inherit system inputs pkgs nixos-hardware extraHomeModules; };

      modules = [
        stylix.nixosModules.stylix
        configurationNix
        defaultNixOptions
      ] ++ extraModules;
    };
  in {
    nixosConfigurations = {
      vm = mkComputer
        ./machines/vm
        [
          ./modules/xserver/i3
          ./modules/xserver/plasma
        ] # extra modules
        [
          ./modules/polybar
          ./modules/i3
          ./modules/fish
        ] # extra modules to be loaded by home-manager
        ;
      laptop = mkComputer
        ./machines/laptop
        [
          ./modules/xserver/i3
          ./modules/xserver/plasma
          ./modules/xserver/hypr
          ./modules/options.nix
        ] # extra modules
        [
          ./modules/polybar
          ./modules/i3
          ./modules/zsh
          ./modules/fish
          ./modules/firefox
          ./modules/git
          ./modules/alacritty
          ./modules/hypr
          ./modules/waybar
          ./modules/options.nix
          ./modules/mako
          ./modules/swaylock
        ] # extra modules to be loaded by home-manager
        ;
    };
  };
}
