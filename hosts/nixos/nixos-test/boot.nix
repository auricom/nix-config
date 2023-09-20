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