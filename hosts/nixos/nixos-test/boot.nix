{ ... }:
{
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/sda";
        useOSProber = true;
      };
    };

    initrd = {
      availableKernelModules = [
        "ahci"
        "ata_piix"
        "ehci_pci"
        "sd_mod"
        "ohci_pci"
        "sr_mod"
      ];
    };
    extraModulePackages = [ ];
  };
}