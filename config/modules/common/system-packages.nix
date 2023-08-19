{ config
, pkgs
, ...
}:

{
  config.environment.systemPackages = with pkgs; [
    curl
    findutils
    gptfdisk
    htop
    iftop
    lsof
    mtr
    nix-output-monitor
    nix-tree
    nixpkgs-fmt
    nmap
    procps
    ps
    tcpdump
    termshark
    tree
    unzip
    xclip
    zip
  ];
}
