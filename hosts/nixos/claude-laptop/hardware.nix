{ lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  fileSystems."/etc/agenix".neededForBoot = true;
}
