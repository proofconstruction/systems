{ config
, lib
, ...
}: {
  options.mine.nix.caches = with lib; {
    nix-community.enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enable the Nix Community cache.
      '';
    };
  };


  config = lib.mkIf config.mine.nix.caches.nix-community.enable {
    nix.settings = {
      substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
