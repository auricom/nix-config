{ ... }:
{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      availableKernelModules = [
        "ahci"
        "sd_mod"
        "usb_storage"
        "usbhid"
        "xhci_pci"
      ];
      kernelModules = [
        "dm-snapshot"
      ];
      luks.devices = {
        "luks-8b222282-655b-40bf-8ef7-abbd62a8fc3f" = {
          device = "/dev/disk/by-uuid/8b222282-655b-40bf-8ef7-abbd62a8fc3f";
        };
      };
    };

    kernelModules = [
      "kvm-intel"
    ];
    extraModulePackages = [ ];
  };
}