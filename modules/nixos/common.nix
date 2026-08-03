# Common NixOS configuration shared between all hosts
{ config, pkgs, lib, ... }:

{
  # Time and locale settings
  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Console
  console.keyMap = "en";

  # X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Services
  services = {
    fwupd.enable = true;
    flatpak.enable = true;
    openssh.enable = true;
    dbus.enable = true;
    power-profiles-daemon.enable = true;
    printing.enable = false;
    xserver.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
  };

  # Nix settings
  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 15d";
    };
  };

  # Universal Allow Unfree
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "qtwebengine-5.15.19" ];

  # Home Manager backup settings
  home-manager.backupFileExtension = "hm-bak";

  # System state version
  system.stateVersion = "25.05";
}
