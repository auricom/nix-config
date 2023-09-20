iso:
  set -euo pipefail
  nix build .#install-iso

check :
  nix flake check
