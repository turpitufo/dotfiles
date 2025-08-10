{
  description = "flake for pNix";

  inputs = {
    
    nixvim.url = "github:nix-community/nixvim";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
    url = "github:nix-community/plasma-manager";
    inputs.nixpkgs.follows = "nixpkgs";
    inputs.home-manager.follows = "home-manager";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { self, nixpkgs, home-manager, chaotic, nur, zen-browser, nixvim,  ... }@inputs: {

    nixosConfigurations.pNix = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit self inputs; };
      modules = [
        ./hosts/pNix/configuration.nix
        home-manager.nixosModules.home-manager
	{
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.d = import ./hosts/pNix/home.nix;
          home-manager.extraSpecialArgs = { inherit inputs self; };

	}
        chaotic.nixosModules.default
        ({pkgs, ...}: {
          environment.systemPackages = [
	      inputs.kwin-effects-forceblur.packages.${pkgs.system}.default
            
          ];
        })
      ];
    };
  };



}

