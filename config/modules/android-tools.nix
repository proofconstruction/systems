{ config
, pkgs
, lib
, ...
}:
{
  options.mine.android-tools.enable = lib.mkEnableOption "adb";

  config = lib.mkIf config.mine.android-tools.enable {

    # allow using android device camera as webcam
    boot = {
      kernelModules = [
        "v4l2loopback"
        "snd-aloop"
      ];
      extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback.out ];

      extraModprobeConfig = ''
        options v4l2loopback exclusive_caps=1 card_label="Virtual Camera"
      '';
    };

    home-manager.users.${config.mine.user.name}.home.packages = with pkgs; [
      android-tools
      (scrcpy.override { ffmpeg = ffmpeg_6.override { withV4l2 = true; }; })
    ];
  };
}
