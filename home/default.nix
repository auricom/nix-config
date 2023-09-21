{ config, pkgs, ... }:
{

  imports = [
    ./alacritty
    ./bluetooth
    ./git
    ./gtk
    ./packages
    ./power-alert
    ./starship
    ./x
  ];

  # First sane reproducible version
  home.stateVersion = "23.05";

  # Who am I?
  home.username = "claude";

  # Start services automatically
  systemd.user.startServices = "sd-switch";
}