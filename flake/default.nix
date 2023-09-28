{ flake-parts
, flake-root
, futils
, treefmt-nix
, ...
} @ inputs:
let
  mySystems = futils.lib.defaultSystems;
in
flake-parts.lib.mkFlake { inherit inputs; } {
  systems = mySystems;

  imports = [
    # treefmt-nix.flakeModule
    flake-root.flakeModule
    ./apps.nix
    ./checks.nix
    ./dev-shells.nix
    ./home-manager.nix
    ./lib.nix
    ./nixos.nix
    ./overlays.nix
    ./packages.nix
    ./templates.nix
  ];
}
