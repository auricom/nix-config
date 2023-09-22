# Common secrets
let
  keys = import ../../keys;

  inherit (keys) all;
in
{
  "users/claude/hashed-password.age".publicKeys = all;
  "users/root/hashed-password.age".publicKeys = all;
  "users/claude/kubeconfig.age".publicKeys = all;
}