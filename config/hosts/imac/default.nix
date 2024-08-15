{ config
, lib
, pkgs
, ...
}:

{
  config = {
    mine = {
      nix.caches = {
        haskell.enable = true;
        nix-community.enable = true;
      };

    };

    roles.workstation.macos = true;
  };

  imports = [
    ./homebrew
    ./macos
    ./network
    ./zsh
  ];
}
