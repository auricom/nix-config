{ config, lib, pkgs, ... }:
let
  cfg = config.my.profiles.homelab;
in
{
  options.my.profiles.homelab = with lib; {
    enable = mkEnableOption "homelab profile";
  };

  config = lib.mkIf cfg.enable {
    # Enable development programs.
    my.home.development.enable = true;
    # Enable Kubernetes clients & configuration.
    my.home.kubernetes-client.enable = true;
    # Enable podman
    my.system.podman.enable = true;
    # Enable ssh client configuration
    my.home.ssh-client.enable = true;
  };
}