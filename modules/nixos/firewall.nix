# Firewall configuration
{ config, pkgs, lib, ... }:

{
  networking.firewall = {
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }   # KDE Connect
      { from = 6881; to = 6999; }
      { from = 11470; to = 11480; }
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }   # KDE Connect
      { from = 6881; to = 6999; }
      { from = 11470; to = 11480; }
    ];
    allowedTCPPorts = [ 32768 32769 22 53 80 443 ];
    allowedUDPPorts = [ 53 67 ];
  };
}
