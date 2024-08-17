{ config
, lib
, pkgs
, home-manager
, ...
}:
let
  cfg = config.custom.user;
in
{
  config = lib.mkIf cfg.enable {
    users.extraUsers.${cfg.name} = {
      createHome = true;
      shell = cfg.shell;
      isNormalUser = true;
      initialPassword = "pass";
      extraGroups = [
        "adbusers"
        "audio"
        "disk"
        "networkmanager"
        "pipewire"
        "power"
        "systemd-journal"
        "video"
        "wheel"
      ];
    };
  };

  imports = [ ./home.nix ];
}
