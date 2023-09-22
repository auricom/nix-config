{ config, pkgs, lib, ... }:
let
  cfg = config.my.home.kubernetes;
in
{
  options.my.home.kubernetes = with lib; {
    enable = my.mkEnableOption "kubernetes configuration";
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