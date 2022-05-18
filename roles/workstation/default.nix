{ config, pkgs, lib, options, home-manager, emacs-overlay, ... }:

{
  imports = [
    # system
    ../../modules/system/cachix.nix
    ../../modules/system/console.nix
    ../../modules/system/environment.nix
    ../../modules/system/fonts.nix
    ../../modules/system/hardware.nix
    ../../modules/system/i18n.nix
    ../../modules/system/nix.nix
    ../../modules/system/services.nix
    ../../modules/system/system.nix
    ../../modules/system/users.nix
    ../../modules/system/virtualisation.nix
  ];
}
