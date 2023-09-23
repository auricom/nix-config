{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.utils;
in
{
  imports = [
    ./kopia.nix
  ];

  options.my.home.utils = with lib; {
    enable = mkEnableOption "utils configuration";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      kopia
      p7zip
      unzip
      xz
      zip
    ];
  };
}