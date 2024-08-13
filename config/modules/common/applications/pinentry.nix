{ config
, lib
, pkgs
, ...
}:

let
  # Taken from https://github.com/nix-community/home-manager/issues/3095#issuecomment-1409028370
  pinentryRofi = pkgs.writeShellApplication {
    name = "pinentry-rofi-with-env";
    text = ''
      PATH="$PATH:${pkgs.coreutils}/bin:${pkgs.rofi}/bin"
      "${pkgs.pinentry-rofi}/bin/pinentry-rofi" "$@"
    '';
  };
in
{
  options.mine.pinentry.enable = lib.mkEnableOption "pinentry";

  config = lib.mkIf config.mine.pinentry.enable {
    home-manager.users.${config.mine.user.name} = lib.mkIf (config.mine.exwm.enable or config.mine.rofi.enable) {
      services.gpg-agent = lib.mkMerge [
        (lib.mkIf config.mine.exwm.enable {
          extraConfig = ''
            allow-emacs-pinentry
            allow-loopback-pinentry
          '';

          pinentryFlavor = "emacs";
        })

        (lib.mkIf config.mine.rofi.enable {
          extraConfig = ''
            pinentry-program ${pinentryRofi}/bin/pinentry-rofi-with-env
          '';

          pinentryFlavor = null;
        })
      ];

      home.packages = lib.mkMerge [
        (lib.mkIf config.mine.rofi.enable [ pkgs.pinentry-rofi ])
        (lib.mkIf config.mine.exwm.enable [ pkgs.pinentry-emacs ])
        (lib.mkIf (!config.mine.rofi.enable && !config.mine.exwm.enable) [ pkgs.pinentry-gtk2 ])
      ];
    };

    # home-manager.users.${config.mine.user.name}.home.file.".gnupg/gpg-agent.conf".text = lib.mkIf pkgs.stdenv.isDarwin ''
    #   pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
    # '';
  };
}
