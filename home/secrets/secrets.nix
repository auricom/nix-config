# Common secrets
let
  keys = import ../../keys;

  inherit (keys) all;
in
{
  "browsers/homepage.age".publicKeys = all;
  "browsers/search.age".publicKeys = all;
  "homelab/kubeconfig.age".publicKeys = all;
  "homelab/minioconfig.json.age".publicKeys = all;
  "homelab/rclone.conf.age".publicKeys = all;
  "homelab/talosconfig.age".publicKeys = all;
}