{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.home.utils;
in {
  imports = [
    ./kopia.nix
  ];

  options.my.home.utils = with lib; {
    enable = mkEnableOption "utils configuration";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      inputs.nixpkgs-unstable.legacyPackages.x86_64-linux.ledger-live-desktop
      kopia
      inputs.nixpkgs-unstable.legacyPackages.x86_64-linux.logseq
      p7zip
      unzip
      xz
      zip
    ];
  };
}
