{ pkgs, home-manager, ... }:
{
  services = {
    kdeconnect.enable = true;
    lorri.enable = true;

    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
      extraConfig = ''
        allow-emacs-pinentry
      '';
    };

    udiskie = {
      enable = true;
      automount = true;
      notify = true;
      tray = "auto";
    };

    unclutter = {
      enable = true;
      extraOptions = [ "exclude-root" "ignore-scrolling" ];
      threshold = 1;
      timeout = 1;
    };

    xscreensaver = {
      enable = true;
      settings = {
        lock = true;
        mode = "blank";
      };
    };

  };
}
