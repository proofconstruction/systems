{ config
, lib
, ...
}:

let
  commonModules = {
    chat.enable = true;
    direnv.enable = true;
    emacs.enable = true;
    fonts.enable = true;
    gnupg.enable = true;
    mob.enable = true;
    password-store.enable = true;
    podman.enable = true;
    rtorrent.enable = true;
    texlive.enable = true;
  };
in
{
  options.roles.workstation.nixos = lib.mkEnableOption "NixOS workstation stuff";
  options.roles.workstation.macos = lib.mkEnableOption "macOS workstation stuff";

  config = lib.mkMerge [
    (lib.mkIf config.roles.workstation.nixos {
      custom = {
        audio.enable = true;
        bluetooth.enable = true;
        cpuMicrocode.enable = true;
        firefox.enable = true;
        flameshot.enable = true;
        redistributableFirmware.enable = true;
        redshift.enable = true;
        rofi.enable = true;
        terminator.enable = true;
        vlc.enable = true;
        zathura.enable = true;
      } // commonModules;
    })

    (lib.mkIf config.roles.workstation.macos {
      custom = commonModules;
    })
  ];
}
