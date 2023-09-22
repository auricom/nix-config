let
  keys = import ../../keys;

  all = builtins.attrValues keys.users;
in
{
  "kubeconfig.age".publicKeys = all;
}