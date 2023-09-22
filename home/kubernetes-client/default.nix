{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.kubernetes-client;
in
{
  options.my.home.kubernetes-client = with lib; {
    enable = mkEnableOption "kubernetes-client configuration";
  };

  config.age.secrets."kubernetes-client/kubeconfig" = {
    path = "$HOME/.kube/config";
  };

  config.home.packages = with pkgs; lib.mkIf cfg.enable [
    fluxcd
    kubectl
    kubeconform
    kubernetes-helm
    helm-docs
    kustomize
    openlens
    popeye
  ];
}