# User configuration
{ config, pkgs, lib, ... }:

{
  users.users.d = {
    isNormalUser = true;
    description = "d";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "input"
      "libvirtd"
      "kvm"
    ];
    packages = with pkgs; [];
  };

  users.groups.libvirtd.members = [ "d" ];
}
