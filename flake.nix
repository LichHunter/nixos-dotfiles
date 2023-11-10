{
  description = "Alex's Flake Config";

  inputs = {

    # Official NixOS package source, using nixos-unstable branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @{ self, nixpkgs, home-manager, nixos-hardware, ... }:
    {
	    nixosConfigurations = {
	      # Run the following command in the flake's directory to
	      # deploy this configuration on any NixOS system:
	      #   sudo nixos-rebuild switch --flake .#nixos-main
	      "nixos" = nixpkgs.lib.nixosSystem {
        modules = [
          ./nixos

          nixos-hardware.nixosModules.omen-15-en1007sa

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.omen = import ./home;
          }
        ];
      };
    };
  };
}
