# Common services configuration
{ config, pkgs, lib, ... }:

{
  services = {
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };
    dbus.enable = true;
    power-profiles-daemon.enable = true;
    printing.enable = false;
    xserver.enable = true;
  };

  programs = {
    fish.enable = true;
    partition-manager.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
    nix-ld.enable = true;
  };
}
