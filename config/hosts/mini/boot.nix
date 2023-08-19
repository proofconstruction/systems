{ config
, pkgs
, ...
}:

{
  config = {
    boot = {
      tmp = {
        useTmpfs = true;
        cleanOnBoot = true;
      };
      initrd = {
        availableKernelModules = [
          "xhci_pci"
          "ehci_pci"
          "ahci"
          "firewire_ohci"
          "usbhid"
          "usb_storage"
          "sd_mod"
          "sdhci_pci"
        ];
      };
      kernelModules = [ "kvm-intel" ];
      kernelPackages = pkgs.linuxPackages_latest;
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };
  };
}
