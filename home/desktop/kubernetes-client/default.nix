{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.home.kubernetes-client;
  fish = config.my.home.fish;
  nushell = config.my.home.nushell;
  talhelper = inputs.talhelper;

  plugin-kubectl-rev = "ced676392575d618d8b80b3895cdc3159be3f628"; # renovate datasource=git-refs depName=evanlucas/fish-kubectl-completions
  plugin-kubectl-hash = "sha256-OYiYTW+g71vD9NWOcX1i2/TaQfAg+c2dJZ5ohwWSDCc="; # depName=evanlucas/fish-kubectl-completions
in {
  options.my.home.kubernetes-client = with lib; {
    enable = mkEnableOption "kubernetes-client configuration";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      auricom.openlens
      fluxcd
      go-task
      kubectl
      kubectx
      kubeconform
      kubernetes-helm
      krew
      helm-docs
      kustomize
      minio-client
      popeye
      pv-migrate
      rclone
      talhelper.packages.x86_64-linux.default
      talosctl
    ];

    programs = {
      k9s = {
        enable = true;
        skin = let
          skin_file = "${inputs.nur-ryan4yin.packages."x86_64-linux".catppuccin-k9s}/dist/macchiato.yml"; # theme - catppuccin mocha
          skin_attr = builtins.fromJSON (
            builtins.readFile
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

      fish = lib.mkIf fish.enable {
        interactiveShellInit = ''
          talosctl completion fish | source
          set -q KREW_ROOT; and set -gx PATH $PATH $KREW_ROOT/.krew/bin; or set -gx PATH $PATH $HOME/.krew/bin
        '';

        shellAliases.k = "kubectl";

        plugins = [
          # kubectl completions for fish shell
          # https://github.com/evanlucas/fish-kubectl-completions
          {
            name = "kubectl-completions";
            src = pkgs.fetchFromGitHub {
              owner = "evanlucas";
              repo = "fish-kubectl-completions";
              rev = "${plugin-kubectl-rev}";
              sha256 = "${plugin-kubectl-hash}";
            };
          }
        ];
      };

      nushell.shellAliases.k = lib.mkIf nushell.enable "kubectl";
    };
  };
}
