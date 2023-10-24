{
  config,
  lib,
  ...
}: let
  cfg = config.my.profiles.nvidia;
in {
  options.my.profiles.nvidia = with lib; {
    enable = mkEnableOption "nvidia profile";
  };

  config = lib.mkIf cfg.enable {
    # Enable nvidia
    my.hardware.nvidia.enable = true;
  };
}
