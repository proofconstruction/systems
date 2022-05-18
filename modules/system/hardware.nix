{ config, pkgs, lib, ...}:

{
  # enable sound
  sound.enable = true;

  # enable hardware devices
  hardware = {
    enableRedistributableFirmware = lib.mkDefault true;

    bluetooth.enable = true;

    opengl = {
      enable = true;
      driSupport = true;
    };

    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };

    # high-resolution display
    video.hidpi.enable = lib.mkDefault true;
  };
}
