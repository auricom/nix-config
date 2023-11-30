{
  config,
  lib,
  ...
}: let
  cfg = config.my.home.homelab;
in {
  imports = [
    ./ssh-client.nix
    ./git.nix
    ./resilio.nix
  ];

  options.my.home.homelab = with lib; {
    enable = mkEnableOption "homelab configuration";
  };

  config = lib.mkIf cfg.enable {
    # atuin configuration
    age.secrets."atuin/config.toml".path = "$HOME/.config/atuin/config.toml";

    # sops (flux)
    age.secrets."homelab/sops" = {
      path = "$HOME/.config/sops/age/keys.txt";
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
