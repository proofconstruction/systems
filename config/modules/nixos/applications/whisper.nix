{ config
, pkgs
, lib
, ...
}:
{
  options.mine.whisper.enable = lib.mkEnableOption "OpenAI's Whisper model";

  config = lib.mkIf config.mine.whisper.enable {
    home-manager.users.${config.mine.user.name}.home.packages =
      if config.mine.nvidia.enable
      then [ (pkgs.openai-whisper.override { cudaSupport = true; }) ]
      else [ pkgs.openai-whisper ];
  };
}
