# KDE Plasma configuration
{ config, pkgs, lib, ... }:

{
  # Enable KDE Plasma
  services.desktopManager.plasma6.enable = true;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Qt configuration
  nixpkgs.config.qt5 = {
    enable = true;
    platformTheme = "qt5ct";
  };

  # XDG Portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
    config = {
      common = {
        default = [ "kde" ];
      };
    };
  };
}
