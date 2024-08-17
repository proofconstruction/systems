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
  options.custom.exwm.enable = lib.mkEnableOption "exwm";

  config = lib.mkIf config.custom.exwm.enable {
    custom.emacs = {
      enable = true;
      configExtra = exwmConfig;
    };

    custom.pinentry.enable = true;

    services.xserver = {
      enable = true;

      layout = "us";

      displayManager.autoLogin = {
        enable = true;
        user = config.custom.user.name;
      };

      windowManager.session = lib.singleton {
        name = "exwm";
        start = ''
          ${config.custom.emacs.package}/bin/emacs -l ${loadScript}
        '';
      };

      displayManager.sessionCommands = "${pkgs.xorg.xhost}/bin/xhost +SI:localuser:$USER";
    };

    # Needed for EXWM to launch programs with counsel-linux-app
    environment.systemPackages = [ pkgs.gtk3 ];
  };
}
