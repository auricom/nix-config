# README.md

<div align="center">

<img src="https://raw.githubusercontent.com/NixOS/nixos-artwork/376ed4ba8dc2e611b7e8a62fdc680967ead5bd87/logo/nix-snowflake.svg" align="center" width="144px" height="144px"/>

## My home Nix configuration

... managed with Flakes and Renovate :robot:
</div>


<div align="center">

[![nixpkgs](https://img.shields.io/badge/nixpkgs-unstable-blue?style=for-the-badge&logo=nixos&logoColor=white)](https://github.com/NixOS/nixpkgs)
[![Renovate](https://img.shields.io/github/actions/workflow/status/auricom/nix-config/renovate.yaml?branch=main&label=&logo=renovatebot&style=for-the-badge&color=blue)](https://github.com/auricom/nix-config/actions/workflows/renovate.yaml)

</div>

## NixOS First install

- Create a custom NixOS install-iso `just iso`
- Put `./result/iso/*` on a Ventoy USB key
- Boot into the installer
- Connect to the Wifi (optional)
- Execute the install script `sudo install-system <host>`
- Reboot
- Log into root account
- Deploy agenix ssh key in `/etc/agenix/identity` and personal ssh key in `/home/<user>/.ssh/id_ed25519`
- Install nix flakes `install-flakes`
- Reboot

## Wifi connection

```
wpa_cli
> add_network
> set_network 0 ssid <ssid>
> set_network 0 psk <passphrase>
> enable_network 0
> save_config
> quit
```

## Resources
* [nixos-hardware] - NixOS profiles to optimize settings for different hardware
* [ryan4yin/nix-config]
* [ambroisie/nix-config]
* [aldoborrero] - nix-generator / disko

_____________

[nixos-hardware]: https://github.com/NixOS/nixos-hardware
[ryan4yin/nix-config]: https://github.com/ryan4yin/nix-config
[ambroisie/nix-config]: https://github.com/ambroisie/nix-config
[aldoborrero]: https://aldoborrero.com/posts/2023/01/15/setting-up-my-machines-nix-style/
