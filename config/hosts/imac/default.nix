{ config
, lib
, pkgs
, ...
}:

{
  config = {
    custom = {
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
