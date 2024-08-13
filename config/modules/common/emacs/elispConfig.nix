{ config
, lib
, ...
}:

let
  elispFiles = [
    ./elisp/performance.el
    ./elisp/package-management.el
    ./elisp/ui.el
    ./elisp/theme.el
    ./elisp/fonts.el
    ./elisp/keybindings.el
    ./elisp/misc.el
    ./elisp/development.el
    ./elisp/misc-packages.el
    ./elisp/utility-functions.el
  ];

  elispConfig = lib.concatLines (map builtins.readFile elispFiles);
in
{
  config.mine.emacs.configText = elispConfig;
}
