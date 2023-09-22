{ config, pkgs, ... }:
{

  imports = [
    ./bluetooth
    ./git
    ./gtk
    ./kubernetes-client
    ./packages
    ./power-alert
    ./secrets
    ./x
  ];

  # First sane reproducible version
  home.stateVersion = "23.05";

  # Who am I?
  home.username = "claude";

  # Start services automatically
  systemd.user.startServices = "sd-switch";
}