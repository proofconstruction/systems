{ config
, pkgs
, lib
, ...
}:
{
  options.custom.whisper.enable = lib.mkEnableOption "OpenAI's Whisper model";

  config = lib.mkIf config.custom.whisper.enable {
    home-manager.users.${config.custom.user.name}.home.packages =
      if config.custom.nvidia.enable
      then [ (pkgs.openai-whisper.override { cudaSupport = true; }) ]
      else [ pkgs.openai-whisper ];
  };
}
