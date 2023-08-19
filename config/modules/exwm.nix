{ config
, pkgs
, lib
, ...
}:

let
  loadScript = pkgs.writeText "emacs-exwm-load" ''
    (require 'exwm-config)
    (exwm-config-default)
    (setq exwm-workspace-show-all-buffers t
          exwm-layout-show-all-buffers t
          mouse-autoselect-window t
          focus-follow-mouse t)
  '';

  exwmConfig = ''
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; EXWM SETTINGS
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ;; Enable EXWM
    (use-package exwm
      :init
      ;; these must be set before exwm is loaded
      (setq mouse-autoselect-window t
            focus-follow-mouse t)
      :config
      (require 'exwm-config)
      (exwm-config-default)

      (setq exwm-workspace-show-all-buffers t)
      (setq exwm-layout-show-all-buffers t))

    ;; Set EXWM Xrandr stuff
    (require 'exwm-randr)
    (setq exwm-randr-workspace-output-plist '(0 "DP-1"))
    (add-hook 'exwm-randr-screen-change-hook
       (lambda ()
         (start-process-shell-command
          "xrandr" nil "xrandr --output DP-2 --mode 2560x1440 --pos 0x0 --auto")))
    (exwm-randr-enable)


    ;; Make EXWM update the buffer title correctly
    (add-hook 'exwm-update-class-hook
              (lambda ()
                (exwm-workspace-rename-buffer exwm-class-name)))

    ;; Refresh EXWM
    (global-set-key (kbd "s-q") 'exwm-restart)

    ;; Launching applications
    (global-set-key (kbd "M-p") #'counsel-linux-app)

    ;; Volume keys
    (global-set-key (kbd "<XF86AudioLowerVolume>")
                    (lambda () (interactive) (shell-command "amixer set Master 5%-")))
    (global-set-key (kbd "<XF86AudioRaiseVolume>")
                    (lambda () (interactive) (shell-command "amixer set Master 5%+")))
    (global-set-key (kbd "<XF86AudioMute>")
                    (lambda () (interactive) (shell-command "amixer set Master 1+ toggle")))

    ;; Brightness keys
    (global-set-key (kbd "<XF86MonBrightnessDown>") (lambda () (interactive) (shell-command "light -U 5; light")))
    (global-set-key (kbd "<XF86MonBrightnessUp>") (lambda () (interactive) (shell-command "light -A 5; light")))

    ;; Lock the screen
    (global-set-key (kbd "<XF86Display>") #'lock-screen)
  '';

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
