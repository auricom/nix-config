{ config, lib, inputs, pkgs, ... }:
let
  cfg = config.my.home.kubernetes-client;
  fish = config.my.home.fish;
  nushell = config.my.home.nushell;
  talhelper = inputs.talhelper;
in
{
  options.my.home.kubernetes-client = with lib; {
    enable = mkEnableOption "kubernetes-client configuration";
  };

  config = lib.mkIf cfg.enable {

    # kubeconfig
    age.secrets."kubernetes-client/kubeconfig" = {
      path = "$HOME/.kube/config";
    };

    # minio-client
    age.secrets."kubernetes-client/minioconfig.json" = {
      path = "$HOME/.mc/config.json";
    };

    # rclone
    age.secrets."kubernetes-client/rclone.conf" = {
      path = "$HOME/.config/rclone/rclone.conf";
    };

    # talos
    age.secrets."kubernetes-client/talosconfig" = {
      path = "$HOME/.talos/config";
    };

    home.packages = with pkgs; [
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
      talhelper.packages.x86_64-linux.default
    ];

    programs.fish.shellAliases = lib.mkIf fish.enable {
      k = "kubectl";
    };
    programs.nushell.shellAliases = lib.mkIf nushell.enable {
      k = "kubectl";
    };
  };
}