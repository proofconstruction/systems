{ config
, lib
, ...
}: {
  options.custom.nix.caches = with lib; {
    haskell.enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enable the IOG Haskell cache.
      '';
    };
  };

  config = lib.mkIf config.custom.nix.caches.haskell.enable {
    nix.settings = {
      substituters = [ "https://cache.iog.io" ];
      trusted-public-keys = [
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      ];
    };
  };
}
