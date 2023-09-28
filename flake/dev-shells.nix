{ ... }:
{
  perSystem = { config, pkgs, ... }: {
    devShells = {
      default = pkgs.mkShellNoCC {
        name = "Nix-config";

        nativeBuildInputs = with pkgs; [
          gitAndTools.pre-commit
          just
          nixpkgs-fmt
        ];

        shellHook = ''
          ${config.pre-commit.installationScript}
        '';
      };
    };
  };
}