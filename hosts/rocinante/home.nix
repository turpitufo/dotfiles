{ config, pkgs, inputs, self, ... }:

let
  allPackages = import ./packages.nix { inherit pkgs; };
in
{
  home.username = "d";
  home.homeDirectory = "/home/d";

  imports = [ 
    ../../modules/home-manager/common.nix
    ../../programs/fastfetch.nix
    ../../programs/fish.nix
    ../../programs/LeChaton.nix
    ../../programs/nvim.nix
    #../../programs/obsidian.nix
  ];

  home.packages = allPackages;

  # Obsidian Flatpak socket fix (rocinante-specific)
  #systemd.user.services.obsidian-socket-fix = {
  #  Unit = {
  #    Description = "Fix Obsidian Flatpak CLI socket location";
  #    WantedBy = [ "graphical-session.target" ];
  #  };
  #  Service = {
  #    Type = "oneshot";
  #    ExecStart = "${pkgs.coreutils}/bin/ln -sf /run/user/%i/.flatpak/md.obsidian.Obsidian/xdg-run/.obsidian-cli.sock /run/user/%i/.obsidian-cli.sock";
  #    RemainAfterExit = true;
  #  };
  #};

  programs = {
    home-manager.enable = true;

    firefox = {
      enable = true;
      configPath = ".mozilla/firefox";
      nativeMessagingHosts = [ pkgs.kdePackages.plasma-browser-integration ];
    };
    #adb.enable = true;
    obsidian.enable = true;
  };
}
