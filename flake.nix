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
      url = "github:LichHunter/stylix";
      # inputs.nixpkgs.follows = "nixpkgs-stable";
    };

    emacs-overlay.url = "github:nix-community/emacs-overlay/master";

    #hyprland.url = "github:hyprwm/Hyprland";
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; # TODO temporary fix while hyprland won't be fixed - https://github.com/hyprwm/Hyprland/issues/5891
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

    # umu-launcher
    umu= {
      url = "git+https://github.com/Open-Wine-Components/umu-launcher/?dir=packaging\/nix&submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    # Uzume dependencies
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    arion.url = "github:hercules-ci/arion";
    sops-nix.url = "github:Mic92/sops-nix";
    vpn-confinement = {
      url = "github:Maroka-chan/VPN-Confinement";
    };
  };

  outputs = inputs@{ self, nixpkgs,
                     home-manager,
                     stylix,
                     nixos-hardware,
                     emacs-overlay,
                     hyprland,
                     nur,
                     arkenfox,
                     disko,
                     ... }:
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
      laptop = mkComputer
        ./machines/laptop
        [
          nixos-hardware.nixosModules.omen-15-en1007sa
          disko.nixosModules.disko
        ] # extra modules
        [
          ./modules/git
          ./modules/alacritty
          ./modules/mako
          #./modules/impermanence
          ./modules/kanshi
          ./modules/shell
          ./modules/browser
          ./modules/vpn
          ./modules/gaming
          ./modules/filemanager/ranger
          ./modules/music/beets
          ./modules/music/ncmpcpp
          ./modules/music/cli-visualizer
          # TODO not yet in my current homemanager, need to update it
          #./modules/fastfetch
          ./modules/distrobox

          #Themes
          # TODO in default.nix we have hardcode config of dconf and this need to be extracted
          #./modules/rice/Frost-Phoenix
          ./modules/rice/my

          arkenfox.hmModules.arkenfox
        ] # extra modules to be loaded by home-manager
        "omen" # username
        ;

      # asus laptop
      uzume = mkComputer
        ./machines/uzume
        [
          disko.nixosModules.disko
          inputs.arion.nixosModules.arion
          inputs.vpn-confinement.nixosModules.default
        ] # extra nix modules
        [
          ./modules/shell/zsh
          ./modules/shell/addon/starship
        ] # extra home-manager modules
        "uzume" #username
        ;
      # minimal install for asus laptop
      uzume-minimal = mkComputer
        ./machines/uzume-minimal
        [
          disko.nixosModules.disko
        ] # extra nix modules
        [
          ./modules/shell/zsh
          ./modules/shell/addon/starship
        ] # extra home-manager modules
        "uzume" #username
        ;
    };
  };
}
