{ config, pkgs, lib, ... }:
let
  cfg = config.my.home.kubernetes;
in
{
  options.my.home.kubernetes = with lib; {
    enable = mkEnableOption "kubernetes configuration";
  };

  imports = [
    inputs.agenix.homeManagerModules.age
  ];

  config.age = {
    secrets =
      let
        toName = lib.removeSuffix ".age";
        toSecret = name: { ... }: {
          file = ./. + "/${name}";
        };
        convertSecrets = n: v: lib.nameValuePair (toName n) (toSecret n v);
        secrets = import ./secrets.nix;
      in
      lib.mapAttrs' convertSecrets secrets;

    # Add my usual agenix key to the defaults
    identityPaths = options.age.identityPaths.default ++ [
      "${config.home.homeDirectory}/.ssh/agenix"
    ];
  };

  environment.etc = {
    # The following secrets are used by home-manager modules
    # So we need to make then readable by the user
    "agenix/kubeconfig" = {
      source = config.age.secrets."kubeconfig.age".path;
      mode = "0644";
    };
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