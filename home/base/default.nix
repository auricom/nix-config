{ config, pkgs, ... }:
{

  imports = [
    ./bat
    ./btop
    ./fish
    ./nushell
    ./packages  
    ./starship
    ./zellij
  ];

}