{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.my.home.productivity;

  jsonFormat = pkgs.formats.json {};
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      discord
    ];

    xdg.configFile."discord/settings.json".source = jsonFormat.generate "discord.json" {
      # Do not keep me from using the app just to force an update
      SKIP_HOST_UPDATE = true;
    };
  };
}
