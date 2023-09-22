# Common secrets
let
  keys = import ../../keys;

  inherit (keys) all;
in
{
  "kubernetes-client/kubeconfig.age".publicKeys = all;
}