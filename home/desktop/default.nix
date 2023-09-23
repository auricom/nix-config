{ config, pkgs, ... }:
{

  imports = [
    ./bluetooth
    ./browsers
    ./development
    ./fonts
    ./gtk
    ./kubernetes-client
    ./media
    ./power-alert
    ./productivity
    ./ssh-client
    ./terminal
    ./utils
    ./x
  ];

}