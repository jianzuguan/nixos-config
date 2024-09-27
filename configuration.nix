# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [
    # include NixOS-WSL modules
    <nixos-wsl/modules>
    <home-manager/nixos>
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  wsl.wslConf.network.generateResolvConf = false;
  

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  networking = {
    networkmanager = {
      enable = true;
      dns = "none";
#      extraConfig = ''
#        [main]
#        rc-manager = resolvconf
#      '';
    };

    nameservers = [   
      "1.1.1.1"
      "1.0.0.1"
      "8.8.8.8"
      "8.8.4.4"
    ];
  };

  environment.systemPackages = [
    pkgs.git
    pkgs.stow
    pkgs.vim
    pkgs.wget
    pkgs.zsh
    pkgs.zsh-powerlevel10k
  ];

  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  programs.zsh.enable = true;

  users.defaultUserShell = pkgs.zsh;  # For Zsh
  
  home-manager.useGlobalPkgs = true;
  home-manager.users.nixos = { pkgs, ... }: {
    home.stateVersion = "24.05";

    imports = [
      ./modules/git.nix
      ./modules/zsh.nix
    ];

  };
}
