# Common Home Manager configuration
{ config, pkgs, lib, ... }:

{
  home.stateVersion = "24.11";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  services.kdeconnect.enable = true;

  programs.home-manager.enable = true;
}
