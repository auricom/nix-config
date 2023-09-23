{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.kubernetes-client;
in
{
  options.my.home.kubernetes-client = with lib; {
    enable = mkEnableOption "kubernetes-client configuration";
  };

  # kubeconfig
  config.age.secrets."kubernetes-client/kubeconfig" = {
    path = "$HOME/.kube/config";
  };

  # minio-client
  config.age.secrets."kubernetes-client/minioconfig.json" = {
    path = "$HOME/.mc/config.json";
  };

  # rclone
  config.age.secrets."kubernetes-client/rclone.conf" = {
    path = "$HOME/rclone/rclone.conf";
  };

  # talos
  config.age.secrets."kubernetes-client/talosconfig" = {
    path = "$HOME/.talos/config";
  };

  # TODO install talhelper

  config.home.packages = with pkgs; lib.mkIf cfg.enable [
    fluxcd
    go-task
    kubectl
    kubeconform
    kubernetes-helm
    helm-docs
    kustomize
    minio-client
    openlens
    popeye
    rclone
  ];
}