{ config, pkgs, lib, ... }:

{
  programs.mistral-vibe = {
    enable = true;
    package = pkgs.mistral-vibe.overrideAttrs (old: {
      doCheck = false;
      doInstallCheck = false; 
    });
    settings = {
      tools.web_search.permission = "always";
    };
  };
}
