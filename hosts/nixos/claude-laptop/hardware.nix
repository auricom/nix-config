{ lib, modulesPath, ... }:
{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/30c57d74-6f0e-44cc-9d28-800143768234";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/2C53-1700";
      fsType = "vfat";
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/4a94595f-708d-4b65-b6f0-276de49e3eeb"; }
  ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  my.hardware = {
    firmware = {
      cpuFlavor = "intel";
    };
  };

  # hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}