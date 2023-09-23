{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.media;
in
{
  config = lib.mkIf cfg.enable {
    programs.mpv = {
      enable = true;

      scripts = [
        pkgs.mpvScripts.mpris # Allow controlling using media keys
      ];
    };
  };
}