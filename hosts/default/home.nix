{
  config,
  pkgs,
  inputs,
  self,
  ...
}:
################### CLEAN SHIT UP MAN CMON
let
  allPackages = import ./packages.nix { inherit pkgs; };
in
{
  home.username = "d";
  home.homeDirectory = "/home/d";

  imports = [
    #../../home/programs/vim.nix
    ../../home/programs/nushell.nix
    #../../home/desktop/hyprland.nix
    #../../home/quickshell/quickshell.nix
    #../../home/desktop/hyprlock.nix
    #../../home/desktop/hypridle.nix
    #../../home/desktop/walker.nix
    ../../home/programs/nixvim.nix
    #../../home/programs/fastfetch.nix
    ##../../home/programs/firefox.nix
    #inputs.hyprland.homeManagerModules.default
    #inputs.nixvim.homeManagerModules.nixvim
    inputs.nixvim.homeManagerModules.nixvim
  ];

  home.packages = allPackages;

  #qt.platformTheme.name = "qt6ct";
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    #style.name = "Darkly";
  };
  #environment.variables.QT_QPA_PLATFORMTHEME = "qt5ct";


# KDE CONNECT

#home-manager.users.d = {
#  services.kdeconnect.enable = true;
#};


  services.kdeconnect.enable = true;





#  xdg.portal = {
#    enable = true;
    #config.common.default = "*";
#   extraPortals = [
      #pkgs.xdg-desktop-portal-gtk
      #pkgs.xdg-desktop-portal-hyprland
#      pkgs.kdePackages.xdg-desktop-portal-kde
#    ];
#
#    config = {
#      common = {
#        default = ["kde"];
#        "org.freedesktop.impl.portal.Secret" = ["gnome-keyring"];
#      };
#    };
#  };

  home.stateVersion = "24.11";

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    EDITOR = "nvim";
  };
  programs = {
    home-manager.enable = true;
    #home-manager.backupFileExtension = "backup";
    firefox = {
      enable = true;
      nativeMessagingHosts = [
        pkgs.kdePackages.plasma-browser-integration 
      ];
    };
  };
}

