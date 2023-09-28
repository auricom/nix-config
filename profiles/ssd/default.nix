{ config, lib, ... }:
let
  cfg = config.my.profiles.ssd;
in
{
  options.my.profiles.ssd = with lib; {
    enable = mkEnableOption "ssd profile";
  };

  config = lib.mkIf cfg.enable {
    # Enable fstrim
    services.fstrim.enable = true;
  };
}