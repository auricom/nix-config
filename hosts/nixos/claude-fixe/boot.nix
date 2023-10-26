{...}: {
  boot = {
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        version = 2;
        device = "nodev";
        efiSupport = true;
        extraEntries = ''
          menuentry "Windows" {
            insmod part_gpt
            insmod fat
            insmod search_fs_uuid
            insmod chain
            search --fs-uuid --set=root 3d44c763-8be4-481b-b1e9-2ab811fcda16
            chainloader /EFI/Microsoft/Boot/bootmgfw.efi
          }
        '';
      };
    };

    initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"];
    initrd.kernelModules = [];

    kernelModules = ["kvm-amd"];
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
