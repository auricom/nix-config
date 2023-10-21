{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.home.media;
  # Create an overriden python that has our custom package
in {
  imports = [
    ./calibre.nix
    ./mpv.nix
  ];

  options.my.home.media = with lib; {
    enable = mkEnableOption "media configuration";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (f.withPackages (ps: [ps.comictagger]))
      calibre
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
