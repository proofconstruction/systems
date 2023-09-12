{ config
, pkgs
, lib
, ...
}:
{
  options.mine.chat.enable = lib.mkEnableOption "chat services";

  config = lib.mkIf config.mine.chat.enable {
    home-manager.users.${config.mine.user.name}.home.packages = with pkgs; [
      jitsi-meet-electron
      signal-desktop
      discord
      fluffychat
      element-desktop
      slack
    ];
  };
}
