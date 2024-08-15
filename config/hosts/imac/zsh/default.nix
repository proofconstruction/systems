{ config
, ...
}:

{
  config = {
    programs.zsh = {
      enable = true;
      enableFzfCompletion = true;
      enableFzfHistory = true;
      shellInit = ''
        source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        source /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      '';
    };
    environment.pathsToLink = [ "/share/zsh" ];
  };
}
