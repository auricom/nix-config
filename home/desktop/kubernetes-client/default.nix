{ config, inputs, lib, pkgs, ... }:
let
  cfg = config.my.home.kubernetes-client;
  catppuccin-k9s = inputs.catppuccin-k9s;
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

    programs = {

      k9s = {
        enable = true;
        skin =
          let skin_file = "${catppuccin-k9s}/dist/macchiato.yml"; # theme - catppuccin mocha
          skin_attr = builtins.fromJSON (builtins.readFile
          # replace 'base: &base "#1e1e2e"' with 'base: &base "default"'
          # to make fg/bg color transparent. "default" means transparent in k9s skin.
          (pkgs.runCommandCC "get-skin-json" {} ''
            cat ${skin_file} \
              | sed -E 's@(base: &base ).+@\1 "default"@g' \
              | ${pkgs.yj}/bin/yj > $out
            '')
            );
          in
            skin_attr;
        };

      fish.shellAliases = lib.mkIf fish.enable {
        k = "kubectl";

      };
      nushell.shellAliases = lib.mkIf nushell.enable {
        k = "kubectl";
      };
    };


  };
}