{ config, pkgs, ... }:
{

  imports = [
    ./aws-cli
    ./bluetooth
    ./browsers
    ./development
    ./fonts
    ./gtk
    ./homelab
    ./hyprland
    ./kubernetes-client
    ./media
    ./power-alert
    ./productivity
    ./terminal
    ./utils
    ./x
  ];

}