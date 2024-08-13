{ config
, pkgs
, lib
, ...
}:

{
  options.mine.texlive.enable = lib.mkEnableOption "texlive";

  config = lib.mkIf config.mine.texlive.enable {
    home-manager.users.${config.mine.user.name}.home.packages = with pkgs; [
      texlive.combined.scheme-full
      imagemagick
      poppler_utils
    ];
  };
}
