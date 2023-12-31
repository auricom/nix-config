# Virtualbox related settings
{
  config,
  lib,
  ...
}: let
  cfg = config.my.system.virtualbox;
in {
  options.my.system.virtualbox = with lib; {
    enable = mkEnableOption "virtualbox configuration";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.virtualbox.host.enable = true;
    boot.kernelModules = ["kvm-amd" "kvm-intel"];
  };
}
