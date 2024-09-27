{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName  = "Jianzu Guan";
    userEmail = "github@jzg.fastmaiil.com";
  };
}
