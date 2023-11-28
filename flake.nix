{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = github:NixOS/nixos-hardware/master;
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, stylix, nixos-hardware, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
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
      ] ++ extraModules;
    };
  in {
    nixosConfigurations = {
      nixos = mkComputer
        ./machines/vm
        "test"
        [] # extra modules
        [
          ./modules/polybar
          ./modules/i3
          ./modules/zsh
          ./modules/fish
        ] # extra modules to be loaded by home-manager
        ;
    };
  };
}
