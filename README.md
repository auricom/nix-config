# First install

- On a Nix host, Generate a custom NixOS ISO for a specific host `just iso <hostname>`
- Deploy the `./result/iso/*.iso` on a Ventoy USB key
- Deploy the agenix private key on `~/.ssh/agenix`
- Execute the `install-system` script to format the disk and install NixOS

# Resources
* [nixos-hardware](https://github.com/NixOS/nixos-hardware) - NixOS profiles to optimize settings for different hardware
* [ryan4yin/nix-config](https://github.com/ryan4yin/nix-config)
* [ambroisie/nix-config](https://github.com/ambroisie/nix-config)
* [aldoborrero](https://aldoborrero.com/posts/2023/01/15/
setting-up-my-machines-nix-style/) - nix-generator / disko