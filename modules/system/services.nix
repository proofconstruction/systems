{ config, pkgs, lib, options, emacs-overlay, ... }:

{
  services = {

    blueman.enable = true;

    devmon.enable = true;

    emacs = {
      enable = true;
      package = import ./emacs.nix {pkgs = pkgs; emacs-overlay=emacs-overlay;};
    };

    localtime.enable = true;

    openssh.enable = true;

    sshd.enable = true;

    # Ergodox needs this to flash new firmware
    udev.extraRules = ''
    # UDEV rules for Teensy USB devices
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
    KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"
    '';

    udisks2.enable = true;

    upower.enable = true;
  };
}
