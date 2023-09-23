# Common secrets
let
  keys = import ../../keys;

  inherit (keys) all;
in
{
  "browsers/homepage.age".publicKeys = all;
  "browsers/search.age".publicKeys = all;
  "kubernetes-client/kubeconfig.age".publicKeys = all;
  "kubernetes-client/minioconfig.json.age".publicKeys = all;
  "kubernetes-client/rclone.conf.age".publicKeys = all;
  "kubernetes-client/talosconfig.age".publicKeys = all;
}