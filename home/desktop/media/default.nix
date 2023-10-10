{ config, lib, pkgs, ... }:
let
  cfg = config.my.home.media;
in
{
  imports = [
    ./calibre.nix
    ./mpv.nix
  ];

  options.my.home.media = with lib; {
    enable = mkEnableOption "media configuration";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      calibre
      # TODO comictagger
      deadbeef-with-plugins
      flameshot
      mediainfo-gui
      picard
      pinta
      vlc
      yt-dlp
    ];
  };
}