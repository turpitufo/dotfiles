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
    hostName = "Hal";
    networkmanager.enable = true;
    networkmanager.plugins = with pkgs; [ networkmanager-sstp ];
  };

  # Hardware-specific: Thinkfan udev rule
  services.udev.extraRules = ''
    KERNEL=="hwmon*", SUBSYSTEM=="hwmon", ATTR{name}=="thinkpad", SYMLINK+="hwmon-thinkpad"
  '';

  # Hardware-specific: AArch64 emulation
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # User shell
  users.users.d.shell = pkgs.nushell;

  # Additional packages not in modules
  environment.systemPackages = with pkgs; [
    # KDE
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
    nushell
    wireplumber
    git
    neovim
    usbutils
    thinkfan
    brightnessctl
    libxcb-cursor
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
  ];

  # Additional services for Hal
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless.enable = false;
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  services = {
    blueman.enable = true;
    clamav = {
      daemon.enable = true;
      updater.enable = true;
    };
    resolved = {
      enable = true;
      settings.Resolve.DNSStubListener = "no";
    };
    openssh.settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "yes";
      KbdInteractiveAuthentication = false;
    };
  };

  programs = {
    steam.enable = true;
    virt-manager.enable = true;
  };

  # Qt5 configuration for Hal
  nixpkgs.config.qt5 = {
    enable = true;
    platformTheme = "qt5ct";
  };

  # Home Manager
  home-manager.users.d = import ./home.nix;
}
