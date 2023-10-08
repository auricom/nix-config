{ config, pkgs, ... }:
{

  imports = [
    ./bat
    ./btop
    ./fish
    ./helix
    ./lsd
    ./neovim
    ./nushell
    ./packages
    ./starship
    ./zellij
    ./zoxide
  ];

}