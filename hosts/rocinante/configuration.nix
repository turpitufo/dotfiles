{ config, pkgs, lib, inputs, self, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/common.nix
    ../../modules/nixos/hardware.nix
    ../../modules/nixos/services.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/kde.nix
    ../../modules/nixos/firewall.nix
  ];

  # Host-specific settings
  networking = {
    hostName = "rocinante";
    networkmanager.enable = true;
    networkmanager.plugins = with pkgs; [ networkmanager-sstp ];
  };

  # Hardware-specific: LUKS encryption
  boot.initrd.luks.devices."luks-06f40cd7-7585-40cd-a701-bc813a68c13b".device = "/dev/disk/by-uuid/06f40cd7-7585-40cd-a701-bc813a68c13b";

  # User shell
  users.users.d.shell = pkgs.fish;

  # Additional packages not in modules
  environment.systemPackages = with pkgs; [
    # KDE
    kdePackages.plasma-desktop
    kdePackages.plasma-workspace
    kdePackages.sddm-kcm
    kdePackages.xdg-desktop-portal-kde
    xdg-desktop-portal
    kdePackages.plasma-browser-integration
    # System
    gcc
    clang
    lsof
    psmisc
    srm
    vim
    wireplumber
    git
    neovim
    usbutils
    thinkfan
    brightnessctl
  ];

  # Fonts
  fonts.packages = with pkgs; [
    fira-sans
    nerd-fonts._0xproto
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    font-awesome
    material-icons
    ncurses
    jetbrains-mono
    victor-mono
    nerd-fonts.tinos
  ];

  # Home Manager
  home-manager.users.d = import ./home.nix;
}
