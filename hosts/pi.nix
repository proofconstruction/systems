{ config, pkgs, lib, options, home-manager, ... }:

let
  hostname = "pi";
in {
  imports = [

    ../roles/workstation
    ../modules/xmonad.nix
  ];

  home.packages = [
    raspberrypifw
    raspberrypi-eeprom
    libraspberrypi
  ];

  networking.hostName = hostname;

  fileSystems = {
    "/" =
      { device = "/dev/disk/by-label/NIXOS_SD";
        fsType = "ext4";
      };
  };

  # 3d acceleration
  hardware.raspberry-pi."4".fkms-3d.enable = true;

  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";

  system.stateVersion = "22.05";
}
