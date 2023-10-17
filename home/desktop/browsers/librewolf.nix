{ config, inputs, pkgs, lib, ... }:
let
  cfg = config.my.home.browsers;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      librewolf
    ];
  };
}