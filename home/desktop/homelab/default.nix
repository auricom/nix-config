{ config, inputs, lib, pkgs, ... }:
let
  cfg = config.my.home.homelab;
in
{
  imports = [
    ./ssh-client.nix
  ];

  options.my.home.homelab = with lib; {
    enable = mkEnableOption "homelab configuration";
  };

  config = lib.mkIf cfg.enable {

    # kubeconfig
    age.secrets."homelab/kubeconfig" = {
      path = "$HOME/.kube/config";
    };

    # minio-client
    age.secrets."homelab/minioconfig.json" = {
      path = "$HOME/.mc/config.json";
    };

    # rclone
    age.secrets."homelab/rclone.conf" = {
      path = "$HOME/.config/rclone/rclone.conf";
    };

    # talos
    age.secrets."homelab/talosconfig" = {
      path = "$HOME/.talos/config";
    };
  };
}