{ config
, pkgs
, ...
}:

{
  config = {
    boot = {
      kernelPackages = pkgs.linuxPackages_rpi4;
      tmp.useTmpfs = true;
      initrd.availableKernelModules = [ "usbhid" "usb_storage" ];
      loader = {
        grub.enable = false;
        generic-extlinux-compatible.enable = true;
      };
    };
  };
}
