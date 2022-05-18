{ config, pkgs, emacs-overlay, ... }:

{
  nix = {
    trustedUsers = [ "root" "alex" ];
    package = pkgs.nixUnstable;
    optimise.automatic = true;
  };

  nixpkgs = {
    config.allowUnfree = true;
    overlays = [ emacs-overlay.overlay ];
  };
}
