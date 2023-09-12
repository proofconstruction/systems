{ config
, pkgs
, lib
, ...
}:

{
  options.roles.workstation = lib.mkEnableOption "workstation stuff";

  config = lib.mkIf config.roles.workstation {
    environment.systemPackages = with pkgs; [
      feh
    ];

    mine = {
      android-tools.enable = true;
      audio.enable = true;
      bluetooth.enable = true;
      chat.enable = true;
      cpuMicrocode.enable = true;
      direnv.enable = true;
      emacs.enable = true;
      firefox.enable = true;
      flameshot.enable = true;
      fonts.enable = true;
      gnupg.enable = true;
      kitty.enable = true;
      mob.enable = true;
      obs-studio.enable = true;
      password-store.enable = true;
      podman.enable = true;
      printing.enable = true;
      redistributableFirmware.enable = true;
      redshift.enable = true;
      rofi.enable = true;
      rtorrent.enable = true;
      texlive.enable = true;
      vlc.enable = true;
      xmonad.enable = true;
      zathura.enable = true;
    };
  };
}
