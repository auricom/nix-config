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
        inputs.agenix.nixosModules.age
        inputs.home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
        ../generators/iso-base.nix
        "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
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

                repo_dir="/mnt/home/claude/repositories/nix-config"

                echo "Format disks..."
                disko

                echo "Generate base nixos config..."
                nixos-generate-config --root /mnt

                echo "Prepare nix-config repository..."
                mkdir -p $repo_dir
                git clone https://github.com/auricom/nix-config $repo_dir

                echo "Installing system..."
                nixos-install --impure --flake $repo_dir#claude-laptop --root /mnt

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
