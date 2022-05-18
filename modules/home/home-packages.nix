{ config, pkgs, home-manager, ...}:

{
  home.packages = with pkgs; [

    # user interface
    pavucontrol
    vanilla-dmz
    gtk3
    terminator
    feh
    xmobar
    xorg.xhost
    unclutter

    # browser
    firefox

    # chat
    element-desktop

    # graphics
    gimp

    # documents
    texlive.combined.scheme-full
    imagemagick
    poppler_utils
    pandoc
    zathura

    # console tools
    tmux psensor nox
    scrot
    gnupg
    xclip
    gptfdisk
    pass pinentry-emacs
    file wireguard-tools
    killall fzf ripgrep-all
    translate-shell
    curl wget
    whois
    exa miniserve
    findutils

    # admin
    gotop htop ps sysstat iotop
    lsof

    # network
    nmap mtr tcpdump iftop termshark

    # media
    vlc

  ];

}
