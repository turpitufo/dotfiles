{ config, pkgs, lib, self, ... }:
{
  programs = {
    fish = {
      enable = true;

      # Fish shell configuration
      shellInit = ''
        # Disable welcome message
        set -g fish_greeting

        # History settings
        set -g history_merge_mode all
        set -g history_time_format "%Y-%m-%d %H:%M:%S"

        # Completion settings
        set -g complete_case_sensitive no
        set -g complete_keep_right yes

        # Prompt - using starship
        function fish_prompt
          starship prompt
        end
      '';

      shellAbbrs = {
        vi = "nvim";
        vim = "nvim";
        nano = "nvim";
        rb = "sudo nixos-rebuild switch --flake /home/d/dotfiles#rocinante";
        rebuild = "sudo nixos-rebuild switch --flake /home/d/dotfiles#rocinante";
        fu = "cd /home/d/dotfiles && nix flake update";
        sync = "cd /home/d/dotfiles && nix flake update && sudo nixos-rebuild switch --flake .#rocinante";
	ls = "eza --long --icons=always --git --header --color-scale --classify always";
      };

      shellAliases = {
        ll = "eza --long --icons=always --git --header --color-scale --classify always";
        la = "eza --icons=always --git --header --color-scale --classify always -a";
      };

      # Fish plugins (using fisher)
      plugins = [
        # Starship is enabled separately via home-manager
        # fisher plugins can be added here if needed
      ];
    };

    # Starship configuration (same as nushell config)
    starship = {
      enable = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[➜](bold green) ";
          error_symbol = "[✗](bold red) ";
        };
      };
    };

    # Carapace settings are managed by shell-specific modules
  };
}
