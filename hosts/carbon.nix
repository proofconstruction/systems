{ config, pkgs, lib, options, home-manager, emacs-overlay, ... }:

let
  hostname = "carbon";
in {
  imports = [
    ../roles/workstation
    ../modules/system/xmonad.nix
  ];

  boot = {
    tmpOnTmpfs = true;
    cleanTmpDir = true;
    initrd = {
      availableKernelModules = [ "xhci_pci" "aesni_intel" "cryptd" "nvme" "usb_storage" "sd_mod" ];
      kernelModules = [ "dm-snapshot" ];
      luks.devices.root = {
        device = "/dev/nvme0n1p2";
        preLVM = true;
      };
    };
    kernelModules = [ "kvm-intel" ];
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/b83ad413-2d9d-4ddf-9af3-7f99edb41e03";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/57B2-4ACB";
      fsType = "vfat";
    };
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/fdbe3cd0-58b6-4e55-a957-3dab35a022e2"; }
  ];

  networking = {
    networkmanager.enable = true;
    hostName = hostname;
    useDHCP = false;
    interfaces = {
      enp0s31f6.useDHCP = true;
      wlp2s0.useDHCP = true;
    };

    firewall = {
      checkReversePath = false;
      allowedTCPPorts = [ 20 21 80 443 8000];
    };

    extraHosts = ''
      192.168.1.10 aj-x1c
    '';
  };

  # backlight function keys
  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 5"; } # Light -
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 5"; } # Light +
    ];
  };

  # interface quality of life
  services.xserver = {
    videoDrivers = [ "intel" ];
    dpi = 210;
    xkbOptions = "ctrl:nocaps";

    libinput = {
      enable = true;
      touchpad = {
        naturalScrolling = true;
        accelSpeed = "0.1";
      };
    };
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  system.stateVersion = "22.05";
}
