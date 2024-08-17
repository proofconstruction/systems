{ config
, lib
, pkgs
, ...
}:

{
  options.custom.nvidia.enable = lib.mkEnableOption "nvidia drivers";

  config = lib.mkIf config.custom.nvidia.enable {
    hardware = {
      graphics = {
        enable = true;
      };

      nvidia = {
        modesetting.enable = true;
        nvidiaSettings = true;
      };
    };

    services.xserver = {
      videoDrivers = [ "nvidia" ];
    };

    home-manager.users.${config.custom.user.name}.home.packages = with pkgs; [
      xorg.xhost
      gwe
    ];
  };
}
