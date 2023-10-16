hostname := `hostname`

agenix file:
  nix run github:ryantm/agenix -- -i ~/.ssh/id_ed25519 -e {{file}}

iso:
  set -euo pipefail
  nix build .#install-iso

check :
  nix flake check
