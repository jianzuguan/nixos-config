{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;  # Enable Zsh
    shellAliases = {
      lsdf = "ls -Ahlv --color --group-directories-first";
    };
  };
  
}
