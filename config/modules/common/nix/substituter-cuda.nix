{ config
, lib
, ...
}: {
  options.custom.nix.caches = with lib; {
    cuda.enable = mkOption {
      type = types.bool;
      default = false;
      description = ''
        Whether to enable the CUDA Maintainers cache.
      '';
    };
  };


  config = lib.mkIf config.custom.nix.caches.cuda.enable {
    nix.settings = {
      substituters = [ "https://cuda-maintainers.cachix.org" ];
      trusted-public-keys = [
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      ];
    };
  };
}
