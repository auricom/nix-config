# Common secrets
let
  keys = import ../../keys;

  inherit (keys) all;
in {
  "atuin/config.toml.age".publicKeys = all;
  "homelab/kubeconfig.age".publicKeys = all;
  "homelab/minioconfig.json.age".publicKeys = all;
  "homelab/rclone.conf.age".publicKeys = all;
  "homelab/sops.age".publicKeys = all;
  "homelab/talosconfig.age".publicKeys = all;
  "wireguard/claude-laptop.conf.age".publicKeys = all;
}
