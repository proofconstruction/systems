{ config
, pkgs
, lib
, ...
}:

{
  options.mine.fonts.enable = lib.mkEnableOption "preferred fonts";

  config = lib.mkIf config.mine.fonts.enable {
    fonts = {
      fontDir.enable = true;
      fontconfig.enable = true;
      enableGhostscriptFonts = true;
      packages = with pkgs; [
        inconsolata
        ubuntu_font_family
        dejavu_fonts
        lmodern
        source-code-pro
        fira
        fira-code
        fira-code-symbols
        fira-mono
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        wqy_microhei
        wqy_zenhei
      ];
    };
  };
}
