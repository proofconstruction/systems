{ config, pkgs, lib, emacs-overlay, ...}:

{
  programs = {
    bash = {
      enableCompletion = true;
    };
    ssh = {
      startAgent = true;
    };
  };

  environment.systemPackages = with pkgs; [
    cachix
    tmux
    wget curl
    htop gotop iftop
    exfat
    zip unzip
    gptfdisk
  ];

  systemd = {
    #power managers need this
    services.upower.enable = true;
  };
}
