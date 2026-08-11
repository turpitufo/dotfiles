{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [ fastfetch ];

  home-file.".config/fastfetch/config.conf" = {
    source = ./configs/fastfetch.conf;
    target = "config.conf";
  };
}
