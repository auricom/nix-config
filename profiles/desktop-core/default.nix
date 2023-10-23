{
  config,
  lib,
  ...
}: let
  cfg = config.my.profiles.desktop-core;
in {
  options.my.profiles.desktop-core = with lib; {
    enable = mkEnableOption "desktop-core profile";
  };

  config = lib.mkIf cfg.enable {
    # Enable browsers
    my.home.browsers.enable = true;

    # Enable fonts
    my.home.fonts.enable = true;

    # Enable media.
    my.home.media.enable = true;

    # enable nfs client
    my.system.nfs-client.enable = true;

    # Enable productivity.
    my.home.productivity.enable = true;

    # Enable Terminal
    my.home.terminal.enable = true;

    # Enable utils
    my.home.utils.enable = true;
  };
}
