{
  config,
  pkgs,
  inputs,
  self,
  ...
}:

let
  allPackages = import ./packages.nix { inherit pkgs; };
in
{
  home.username = "d";
  home.homeDirectory = "/home/d";

  imports = [
    ../../modules/home-manager/common.nix
    ../../programs/fastfetch.nix
    ../../programs/nushell.nix
    ../../programs/LeChaton.nix
    ../../programs/nvim.nix
  ];

  home.packages = allPackages;

  programs = {
    home-manager.enable = true;
    
    firefox = {
      enable = true;
      nativeMessagingHosts = [
        pkgs.kdePackages.plasma-browser-integration  
      ];
      configPath = "${config.xdg.configHome}/mozilla/firefox";

    };

    #mistral-vibe = {
    #  enable = true;
    #package = pkgs.mistral-vibe.overrideAttrs (old: { doCheck = false; });
    #};

  };
}
