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
        availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
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
