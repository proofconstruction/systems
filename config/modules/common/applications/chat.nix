{ config
, pkgs
, lib
, ...
}:
{
  options.custom.chat.enable = lib.mkEnableOption "chat services";

  config = lib.mkIf config.custom.chat.enable {
    home-manager.users.${config.custom.user.name}.home.packages = with pkgs; [
      # jitsi-meet-electron
      signal-desktop
      #discord
      #element-desktop
      #slack
      #zoom-us
    ];
  };
}
