{ config, pkgs, lib, self, ... }:
{
programs = {
    nushell = { enable = true;
      # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
      #configFile.source = ./.../config.nu;
      # for editing directly to config.nu 
      extraConfig = ''
       let carapace_completer = {|spans|
       carapace $spans.0 nushell ...$spans | from json
       }
       $env.config = {
        show_banner: false,
        completions: {
        case_sensitive: false # case-sensitive completions
        quick: true    # set to false to prevent auto-selecting completions
        partial: true    # set to false to prevent partial filling of the prompt
        algorithm: "fuzzy"    # prefix or fuzzy
        external: {
        # set to false to prevent nushell looking into $env.PATH to find more suggestions
            enable: true 
        # set to lower can improve completion performance at the cost of omitting some options
            max_results: 100 
            completer: $carapace_completer # check 'carapace_completer' 
          }
        }
       } 
       $env.PATH = ($env.PATH | 
       split row (char esep) |
       prepend /home/myuser/.apps |
       append /usr/bin/env
       )

       # Custom functions for complex commands
       def fu [] {
         cd /home/d/pNix
         nix flake update
       }
       
       def sync [] {
         cd /home/d/pNix
         nix flake update
         sudo nixos-rebuild switch --flake .#pNix
       }
       '';
       shellAliases = {
       vi = "nvim";
       vim = "nvim";
       nano = "nvim";
       rb = "sudo nixos-rebuild switch --flake /home/d/pNix#pNix";
       rebuild = "sudo nixos-rebuild switch --flake /home/d/pNix#pNix";
       };
   };  
   carapace.enable = true;
   carapace.enableNushellIntegration = true;
   starship = { enable = true;
       settings = {
         add_newline = true;
         character = { 
         success_symbol = "[➜](bold green) ";
         error_symbol = "[✗](bold red) ";
       };
    };
  };
};
}

