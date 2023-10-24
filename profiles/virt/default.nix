{
  config,
  lib,
  ...
}: let
  cfg = config.my.profiles.virt;
in {
  options.my.profiles.virt = with lib; {
    enable = mkEnableOption "virt profile";
  };

  config = lib.mkIf cfg.enable {
    # Enable virtualbox
    my.system.virtualbox.enable = true;
  };
}
