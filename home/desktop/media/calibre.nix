{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.media;
in
{
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      calibre # NOTE: relies on my overlay to add necessary plug-in dependencies
    ];
  };
}