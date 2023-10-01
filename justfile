hostname := `hostname`

agenix file:
  nix run github:ryantm/agenix -- -i ~/.ssh/agenix -e {{file}}

build host:
  set -euo pipefail
  nix build ./#nixosConfigurations.{{host}}.config.system.build.toplevel

iso host:
  set -euo pipefail
  nix build .#{{host}}-iso

check :
  nix flake check

fmt:
  treefmt

rebuild:
  sudo nixos-rebuild switch --flake ./#{{hostname}}

update :
  nix flake update
