{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = github:NixOS/nixos-hardware/master;
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
    emacs-overlay.url = "github:nix-community/emacs-overlay/master";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, stylix, nixos-hardware, emacs-overlay, hyprland, ... }:
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

    mkComputer = configurationNix: username: extraModules: extraHomeModules: inputs.nixpkgs.lib.nixosSystem {
      inherit system ;
      specialArgs = { inherit system inputs pkgs nixos-hardware; };

      modules = [
        stylix.nixosModules.stylix
        configurationNix
        defaultNixOptions

        #(./. + "/users/${username}") # user config?

        home-manager.nixosModules.home-manager
        {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."${username}" = {
              imports = [ (./. + "/users/${username}/home.nix") ] ++ extraHomeModules;
            };
        }

        hyprland.nixosModules.default
      ] ++ extraModules;
    };
  in {
    nixosConfigurations = {
#     nixos = mkComputer
#       ./machines/vm
#       "test"
#       [
#         ./modules/xserver/i3
#         ./modules/xserver/plasma
#       ] # extra modules
#       [
#         ./modules/polybar
#         ./modules/i3
#         ./modules/zsh
#         ./modules/fish
#         ./modules/firefox
#         ./modules/git
#         ./modules/alacritty
#       ] # extra modules to be loaded by home-manager
#       ;
      nixos = mkComputer
        ./machines/laptop
        "omen"
        [
          ./modules/xserver/i3
          ./modules/xserver/plasma
          ./modules/xserver/hypr
        ] # extra modules
        [
          ./modules/polybar
          ./modules/i3
          ./modules/zsh
          ./modules/fish
          ./modules/firefox
          ./modules/git
          ./modules/alacritty
        ] # extra modules to be loaded by home-manager
        ;
    };
  };
}
