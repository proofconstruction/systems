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
          "nvme"
          "xhci_pci"
          "ahci"
          "usb_storage"
          "usbhid"
          "sd_mod"
        ];
      };

      kernelModules = [ "kvm-amd" ];
      kernelPackages = pkgs.linuxPackages_latest;
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
    };
  };
}
