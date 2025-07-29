{
  config,
  pkgs,
  inputs,
  lib,
  self,
  ...
}:

{
  imports = [
      ./hardware-configuration.nix
  ];


  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.kdePackages.xdg-desktop-portal-kde];
    config = {
      common = {
        default = [ "kde" ]; # or "gtk", "hyprland", etc. depending on session
        #"org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ]; # or "kwallet" if applicable
      };
    };
  };






  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    bluetooth = {
    enable = true;
    powerOnBoot = true;
    };
  };

  #BOOT
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "thinkpad_acpi" ];
    extraModprobeConfig = ''
      options thinkpad_acpi fan_control=1
    '';

  };

  services.udev.extraRules = ''
    KERNEL=="hwmon*", SUBSYSTEM=="hwmon", ATTRS{name}=="thinkpad_hwmon", SYMLINK+="hwmon-thinkpad"
  '';





  nixpkgs.config.qt5 = {
    enable = true;
    platformTheme = "qt5ct";
  };

##        ?HANDLED BY KDE?
#  environment.variables = {
#    XCURSOR_SIZE = "24";
#    QT_QPA_PLATFORM = "wayland";
#  };


  networking = {
    hostName = "pNix";
    #wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;
  };



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
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  console.keyMap = "en";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.d = {
    isNormalUser = true;
    description = "d";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "input"
    ];
    shell = pkgs.nushell;
    packages = with pkgs; [];
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  gcc
  clang
  lsof
  psmisc
  srm
  vim
  nushell
  #hyprland
  wireplumber
  git
  neovim
  usbutils
  thinkfan
  brightnessctl
  #KDE
  kdePackages.plasma-desktop
  kdePackages.plasma-workspace
  kdePackages.sddm-kcm
  inputs.zen-browser.packages.${pkgs.system}.default
  kdePackages.xdg-desktop-portal-kde
  xdg-desktop-portal
  #xdg-desktop-portal-gtk # optional fallback
  #gnome-keyring     # or use kwallet if preferred
  libsForQt5.plasma-browser-integration
  kdePackages.plasma-browser-integration
];

  fonts = {
    packages = with pkgs; [
      fira-sans
      nerd-fonts._0xproto
      noto-fonts-emoji
      noto-fonts-cjk-sans
      font-awesome
      #symbola
      material-icons
      ncurses
      jetbrains-mono
      victor-mono
    ];
  };

# Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  #programs.zsh.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # SERVICES
  services = {
    #cider.enable = true;
    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };
    openssh.enable = true;
    dbus.enable = true;
    power-profiles-daemon.enable = true;
    printing.enable = false;
    blueman.enable = true;
    xserver.enable = true;
    displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    };
    desktopManager.plasma6.enable = true;
    clamav = {
      daemon.enable = true;
      updater.enable = true; 
    };
  };

  #xdg.portal.enable = true;

  home-manager.backupFileExtension = "backup";

  nixpkgs.config.allowUnfree = true;

  nix = {
    settings = {
      experimental-features = [
      "nix-command"
      "flakes"
      ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 15d";
    };
  };





  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
#CHANGED ANYWAYS?
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";


    # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.firewall = rec {
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = allowedTCPPortRanges;
  };




}
