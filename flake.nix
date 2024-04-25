{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      # inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    emacs-overlay.url = "github:nix-community/emacs-overlay/master";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    split-monitor-workspaces = {
      url = "github:Duckonaut/split-monitor-workspaces";
      inputs.hyprland.follows = "hyprland"; # <- make sure this line is present for the plugin to work as intended
    };

    nur.url = "github:nix-community/NUR";

    arkenfox.url = "github:dwarfmaster/arkenfox-nixos";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = inputs@{ self, nixpkgs,
                     home-manager,
                     stylix,
                     nixos-hardware,
                     emacs-overlay,
                     hyprland,
                     nur,
                     arkenfox, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
      overlays = [
        emacs-overlay.overlay
        nur.overlay
        (import ./my-overlays.nix)
      ];
    };
    spkgs = import inputs.nixpkgs-stable {
      inherit system;
      config = {
        allowUnfree = true;
      };
      overlays = [
        emacs-overlay.overlay
        nur.overlay
        (import ./my-overlays.nix)
      ];
    };

    defaultNixOptions = {
      nix.settings.auto-optimise-store = true;
    };

    mkComputer = configurationNix: extraModules: extraHomeModules: username: inputs.nixpkgs.lib.nixosSystem {
      inherit system ;
      specialArgs = { inherit system inputs pkgs nixos-hardware extraHomeModules spkgs username; };

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
          ./modules/shell/fish
        ] # extra modules to be loaded by home-manager
        ;
      laptop = mkComputer
        ./machines/laptop
        [
          ./modules/options.nix

        ] # extra modules
        [
          ./modules/polybar
          ./modules/git
          ./modules/alacritty
          ./modules/options.nix
          ./modules/mako
          ./modules/impermanence
          ./modules/kanshi
          ./modules/shell/zsh
          ./modules/shell/fish
          ./modules/browser
          ./modules/vpn
          ./modules/gaming

          #Themes
          # TODO in default.nix we have hardcode config of dconf and this need to be extracted
          #./modules/rice/Frost-Phoenix
          ./modules/rice/my

          arkenfox.hmModules.arkenfox
        ] # extra modules to be loaded by home-manager
        "omen"
        ;
    };
  };
}
