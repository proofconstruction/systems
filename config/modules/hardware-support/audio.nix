{ config
, lib
, pkgs
, ...
}:

{
  options.mine.audio.enable = lib.mkEnableOption "audio stuff";

  config = lib.mkIf config.mine.audio.enable {
    sound.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      audio.enable = true;
      pulse.enable = true;
      jack.enable = true;
    };

    home-manager.users.${config.mine.user.name}.home.packages = with pkgs; [
      pavucontrol
      helvum
    ];
  };
}
