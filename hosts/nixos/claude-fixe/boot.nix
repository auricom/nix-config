{...}: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
    initrd.kernelModules = [];

    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [];

    supportedFilesystems = [
      "ext4"
      "btrfs"
      "xfs"
      #"zfs"
      "ntfs"
      "fat"
      "vfat"
      "exfat"
      "cifs" # mount windows share
    ];
  };
}
