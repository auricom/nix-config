# Throttled power management
{
  config,
  lib,
  ...
}: let
  cfg = config.my.services.throttled;
in {
  options.my.services.throttled = {
    enable = lib.mkEnableOption "Throttled power management configuration";
  };

  config = lib.mkIf cfg.enable {
    services.throttled = {
      enable = true;
    };
  };
}
