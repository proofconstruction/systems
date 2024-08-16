{ config
, ...
}:

{
  config = {
    custom = {
      nix.caches = {
        haskell.enable = true;
        cuda.enable = true;
        nix-community.enable = true;
      };

      cpuMicrocode = {
        enable = true;
        manufacturer = "amd";
      };

      nvidia.enable = true;
    };

    roles = {
      ai-host = true;
      binary-cache = true;
      database-host = true;
      dns-server = true;
      download-server = true;
      git-server = true;
      media-server = true;
      vm-host = true;
    };
  };

  imports = [
    ./boot.nix
    ./networking.nix
    ./filesystems.nix
  ];
}
