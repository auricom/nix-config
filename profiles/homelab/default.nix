{
  config,
  lib,
  ...
}: let
  cfg = config.my.profiles.homelab;
in {
  options.my.profiles.homelab = with lib; {
    enable = mkEnableOption "homelab profile";
  };

  config = lib.mkIf cfg.enable {
    # Enable homelab configuration.
    my.home.homelab.enable = true;

    # Enable virtualbox
    my.system.virtualbox.enable = true;
  };
}
