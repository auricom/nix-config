{ config, lib, options, pkgs, ... }:
let
  cfg = config.my.home.kubernetes;
  secrets = config.age.secrets;
in
{
  options.my.programs.kubernetes = with lib; {
    enable = mkEnableOption "kubernetes configuration";
  };

  home.file".kube/config" = {
    source = secrets."kubernetes-client/kubeconfig".path;
    mode = "0644";
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