{ config
, lib
, pkgs
, ...
}:

{
  options.mine.nvidia.enable = lib.mkEnableOption "nvidia drivers";

  config = lib.mkIf config.mine.nvidia.enable {
    hardware = {
      opengl = {
        enable = true;
        driSupport = true;
      };

      nvidia = {
        modesetting.enable = true;
        nvidiaSettings = true;
      };
    };

    services.xserver = {
      videoDrivers = [ "nvidia" ];
    };

    home-manager.users.${config.mine.user.name}.home.packages = with pkgs; [
      xorg.xhost
      gwe
    ];
  };
}
