{
  description = "pNix system configuration";

  inputs = {
    # Core
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Hardware-specific
    nixos-06cb-009a-fingerprint-sensor = {
      url = "github:viktor-grunwaldt/t480-fingerprint-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Package repositories
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nur.url = "github:nix-community/NUR";

    # User environment
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, chaotic, nur, nixos-06cb-009a-fingerprint-sensor, ... }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
    in {
      nixosConfigurations.pNix = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit self inputs; };

        modules = [
          # System configuration
          ./hosts/pNix/configuration.nix

	  # Universal Allow Unfree
	  { nixpkgs.config.allowUnfree = true; }

          # Hardware modules
          nixos-06cb-009a-fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"

          # Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.d = import ./hosts/pNix/home.nix;
              extraSpecialArgs = { inherit inputs self; };
            };
          }

          # Package overlays
          {
            nixpkgs.overlays = [
              (self: super: {
                mistral-vibe = super.mistral-vibe.overrideAttrs (old: {
                  doCheck = false;
                });
              })
            ];
	  }
        ];
      };
    };
}
