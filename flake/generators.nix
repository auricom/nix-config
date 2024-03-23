{
  self,
  inputs,
  lib,
  ...
}: {
  perSystem = {pkgs, ...}: let
    inherit (inputs) nixos-generators;
    inherit (lib) mkForce;
    keys = import ../keys;

    defaultModule = {...}: {
      _module.args.self = self;
      _module.args.inputs = inputs;
      imports = [
        "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
      ];
    };
  in {
    packages = {
      install-iso = nixos-generators.nixosGenerate {
        inherit pkgs;
        format = "install-iso";
        modules = [
          defaultModule
          (
            {pkgs, ...}: let
              install-system = pkgs.writeShellScriptBin "install-system" ''
                set -euo pipefail

                # Check if there is exactly one argument
                if [ "$#" -ne 1 ]; then
                  echo "ERROR - Please provide the target host as argument."
                  exit 1
                fi

                # Prompt for confirmation
                read -p "Do you want to format ? (y/n) " choice
                if [ "$choice" != "y" ]; then
                  echo "Script execution aborted."
                  exit 1
                fi

                host=$1

                disko_url="https://raw.githubusercontent.com/auricom/nix-config/main/hosts/nixos/$host/disko.nix"

                # Download disko configuration
                if ! curl --silent --location  "$disko_url" --output /tmp/disko.nix ; then
                  echo "ERROR - Disko configuration download failed. "
                  exit 1
                fi

                # Apply disko configuration and format disks
                nix \
                  --extra-experimental-features flakes \
                  --extra-experimental-features nix-command \
                  run github:nix-community/disko -- \
                  --mode disko /tmp/disko.nix

                # Generate nixos configuration
                nixos-generate-config --root /mnt

                # Download base configuration

                nixos_url="https://raw.githubusercontent.com/auricom/nix-config/main/dummy-configuration.nix"

                # Download disko configuration
                if ! curl --silent --location  "$nixos_url" --output /mnt/etc/nixos/configuration.nix ; then
                  echo "ERROR - Nixos configuration download failed. "
                  exit 1
                fi

                # Install NixOS
                nixos-install

                echo "INFO - Done!"
              '';
            in {
              environment.systemPackages = with pkgs; [
                install-system
              ];
              users.extraUsers.root.openssh.authorizedKeys.keys = [
                keys.users.claude
              ];
              systemd.services.sshd.wantedBy = mkForce ["multi-user.target"];
            }
          )
        ];
      };
    };
  };
}
