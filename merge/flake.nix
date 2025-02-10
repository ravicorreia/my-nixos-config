{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgsStable.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    fine-cmdline = {
      url = "github:VonHeikemen/fine-cmdline.nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs:
    let
      sytem = "x86_64-linux";
      legacy = "legacyPackages";
      pkgs = nixpkgs.${legacy}.${sytem};
      pkgsStable = inputs.nixpkgsStable.${legacy}.${sytem};
    in {
      nixosConfigurations = {
        baobab = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./configuration.nix
            inputs.stylix.nixosModules.stylix
            # inputs.home-manager.nixosModules.default
          ];
        };
      };
      homeConfigurations = {
        ravicorreia = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [
            ./home.nix
          ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };
      };
      nixosConfigurations = {
        baobab-backup = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./configuration.nix
            # inputs.home-manager.nixosModules.default
          ];
        };
      };
    };
}
