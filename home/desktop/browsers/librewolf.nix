{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.my.home.browsers;
in {
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      librewolf
    ];

    home.file.".librewolf/librewolf.overrides.cfg".text = ''
      defaultPref("identity.fxaccounts.enabled", true);
      defaultPref("privacy.clearOnShutdown.history", false);
      defaultPref("privacy.clearOnShutdown.downloads", false);
    '';
  };
}
