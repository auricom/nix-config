hostname := `hostname`


agenix file:
  nix run github:ryantm/agenix -- -i ~/.ssh/agenix -e {{file}}

flash-iso-image host:
  set -euo pipefail

  nix build ./#{{host}}

  iso="./result/iso/"
  iso="$iso$(ls "$iso | ${pv}")"
  dev="/dev/$(lsblk -d -n --output RM,NAME,FSTYPE,SIZE,LABEL,TYPE,VENDOR,UUID | awk '{if ($1 == 1) { print } }' | fzf | awk '{print $2}')"

  pv -tpreb "$iso" | sudo dd bs=4M of="$dev" iflag=fullblock conv=notrunc,noerror oflag=sync

fmt:
  treefmt

rebuild:
  sudo nixos-rebuild switch --flake ./#{{hostname}}
