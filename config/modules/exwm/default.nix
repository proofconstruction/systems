{ config
, pkgs
, lib
, ...
}:

let
  loadScript = builtins.readFile ./emacs-exwm-load.el;
  exwmConfig = builtins.readFile ./exwm.el;
in
{
  options.mine.exwm.enable = lib.mkEnableOption "exwm";

  config = lib.mkIf config.mine.exwm.enable {
    mine.emacs = {
      enable = true;
      configExtra = exwmConfig;
    };

    mine.pinentry.enable = true;

    services.xserver = {
      enable = true;

      layout = "us";

      displayManager.autoLogin = {
        enable = true;
        user = config.mine.user.name;
      };

      windowManager.session = lib.singleton {
        name = "exwm";
        start = ''
          ${config.mine.emacs.package}/bin/emacs -l ${loadScript}
        '';
      };

      displayManager.sessionCommands = "${pkgs.xorg.xhost}/bin/xhost +SI:localuser:$USER";
    };

    # Needed for EXWM to launch programs with counsel-linux-app
    environment.systemPackages = [ pkgs.gtk3 ];
  };
}
