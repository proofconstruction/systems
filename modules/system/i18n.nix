{ config, pkgs, lib, ...}:

{
  #enable alt keyboard input
  i18n.inputMethod = {
    enabled = "fcitx";
    fcitx.engines = with pkgs.fcitx-engines; [ rime ];
  };
}
