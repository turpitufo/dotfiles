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
    nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    # Basic options
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      smartindent = true;
      wrap = false;
      swapfile = false;
      termguicolors = true;
    };

    # Plugins
    plugins = {
      lualine = {
        enable = true;
      };
      web-devicons = {
        enable = true;
      };

      nvim-tree = {
        enable = true;
        openOnSetup = true;
        disableNetrw = true;
        hijackNetrw = true;
        updateFocusedFile.enable = true;
        view = {
          width = 30;
          side = "left";
        };
        renderer = {
          highlightGit = true;
          icons.show.file = true;
          icons.show.folder = true;
        };
      };

      telescope = {
        enable = true;
      };

      treesitter = {
        enable = true;
      };
      
      presence-nvim = {
        enable = true;
        enableLineNumber = true;
        autoUpdate = true;
      };

      cmp.enable = true;
      comment.enable = true;

      vim-surround.enable = true;
      fugitive.enable = true;

      # LSP plugin and servers
      lsp = {
        enable = true;
        servers = {
          lua_ls = {};
          pyright = {};
          ts_ls = {};
          nil_ls = {
            enable = true;
            settings = {
              formatting.command = ["nixpkgs-fmt"];
            };
          };
        };
      };
    };

    globals = {
      mapleader = " ";      # Use space as leader
      maplocalleader = " "; # Optional: set local leader too
    };

    # Key mappings
    keymaps = [
      {
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<cr>";
        options.desc = "Find files";
      }
      {
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<cr>";
        options.desc = "Live grep";
      }
      {
        key = "<leader>w";
        action = "<cmd>NvimTreeToggle<cr>";
        options.desc = "Toggle file explorer";
      }
      {
        key = "<leader>n";
        action = "<cmd>NvimTreeFindFile<cr>";
        options.desc = "Find current file in explorer";
      }
    ];
  };
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

