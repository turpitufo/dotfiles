{ config, pkgs, lib, ... }:

{
  programs.mistral-vibe = {
    enable = true;
    package = pkgs.mistral-vibe.overrideAttrs (old: {
      doCheck = false;
    });
    settings = {
      tools.web_search.permission = "always";
    };
  };
}
