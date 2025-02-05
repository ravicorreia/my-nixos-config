{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgsStable.url = "github:nixos/nixpkgs/nixos-24.11";

    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, ... } @ inputs:
  let
    sytem = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${sytem};
    pkgsStable = inputs.nixpkgsStable.legacyPackages.${sytem};
  in {
    nixosConfigurations {
      wasabi = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./configuration.nix
          # inputs.home-manager.nixosModules.default
        ];
      };
    };
  };
}
