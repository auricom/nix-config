{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.productivity;
in
{
  imports = [
    ./discord.nix
  ];

  options.my.home.productivity = with lib; {
    enable = mkEnableOption "productivity configuration";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      _1password-gui
      bitwarden
      joplin-desktop
    ];
  };
}