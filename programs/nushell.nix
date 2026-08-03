{ config, pkgs, lib, self, ... }:
{
programs = {
    nushell = { enable = true;
      
      
      extraConfig = ''
       let carapace_completer = {|spans|
       carapace $spans.0 nushell ...$spans | from json
       }
       $env.config = {
        show_banner: false,
        completions: {
        case_sensitive: false 
        quick: true    
        partial: true    
        algorithm: "fuzzy"    
        external: {
        
            enable: true 
        
            max_results: 100 
            completer: $carapace_completer 
          }
        }
       } 
       $env.PATH = ($env.PATH | 
       split row (char esep) |
       prepend /home/d/.apps |
       append /usr/bin/env
       )

       
       def fu [] {
         nix flake update
       }
       
       def sync [] {
         nix flake update
         sudo nixos-rebuild switch --flake .#
       }
       '';
       shellAliases = {
       vi = "nvim";
       vim = "nvim";
       nano = "nvim";
       rb = "sudo nixos-rebuild switch --flake .#";
       rebuild = "sudo nixos-rebuild switch --flake .#";
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