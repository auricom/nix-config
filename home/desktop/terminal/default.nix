{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.terminal;
in
{
  imports = [
    ./alacritty.nix
    ./kitty.nix
  ];

  options.my.home.terminal = with lib; {
    enable = mkEnableOption "terminal configuration";
  };
}
