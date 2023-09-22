{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.fish;
in
{
  options.my.home.fish = with lib; {
    enable = mkEnableOption "fish configuration";
  };
}