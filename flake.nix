{
  description = "flake for pNix";

  inputs = {

    nixos-06cb-009a-fingerprint-sensor = {
      url = "github:viktor-grunwaldt/t480-fingerprint-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nur.url = "github:nix-community/NUR";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #plasma-manager = {
    #url = "github:nix-community/plasma-manager";
    #inputs.nixpkgs.follows = "nixpkgs";
    #inputs.home-manager.follows = "home-manager";
    #};

#    calibData = {
#      url = "path:./hosts/pNix/calib-data.bin";
#    };


  };


  outputs = { self, 
  nixpkgs, 
  home-manager, 
  chaotic, 
  nur, 
  nixos-06cb-009a-fingerprint-sensor,
#  calibData,
  ... }@inputs: {

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
	nixos-06cb-009a-fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"

     ];
    };
  };



}

