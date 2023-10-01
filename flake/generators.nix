{
  self,
  inputs,
  ...
}: {
  perSystem = {
    self',
    pkgs,
    ...
  }: let
    inherit (inputs) nixos-generators;

    defaultModule = {...}: {
      imports = [
        inputs.disko.nixosModules.disko
        ../generators/iso-base.nix
      ];
      _module.args.self = self;
      _module.args.inputs = inputs;
    };
  in {
    packages = {
      claude-laptop-iso = nixos-generators.nixosGenerate {
        inherit pkgs;
        format = "install-iso";
        modules = [
          defaultModule
          ({ config, lib, pkgs, self, ...}:
            let
              # disko
              disko = pkgs.writeShellScriptBin "disko" ''${config.system.build.diskoScript}'';

              # system
              system = self.nixosConfigurations.claude-laptop.config.system.build.toplevel;

              install-system = pkgs.writeShellScriptBin "install-system" ''
                set -euo pipefail

                echo "Formatting disks..."
                . disko-format/bin/disko-format

                echo "Mounting disks..."
                . disko-mount/bin/disko-mount

                echo "Installing system..."
                nixos-install --system ${system}

                echo "Done!"
              '';
            in {
              imports = [
                ../hosts/nixos/claude-laptop/disko.nix
              ];

              # we don't want to generate filesystem entries on this image
              disko.enableConfig = lib.mkDefault false;

              # add disko commands to format and mount disks
              environment.systemPackages = [
                disko

                install-system
              ];
            }
          )
        ];
      };
    };
  };
}
