{ config
, pkgs
, lib
, ...
}:

{
  options.custom.texlive.enable = lib.mkEnableOption "texlive";

  config = lib.mkIf config.custom.texlive.enable {
    home-manager.users.${config.custom.user.name}.home.packages = with pkgs; [
      texlive.combined.scheme-full
      imagemagick
      poppler_utils
    ];
  };
}
