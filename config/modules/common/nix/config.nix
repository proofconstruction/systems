{ config
, lib
, pkgs
, ...
}: {
  config = lib.mkMerge [
    {
      nix = {
        package = pkgs.nixVersions.git;

        extraOptions = ''
          experimental-features = nix-command flakes
          keep-outputs = true
          keep-derivations = true
        '';

        settings = {
          trusted-users = [
            "@admin"
            config.custom.user.name
          ];

          # optimise each build
          auto-optimise-store = true;
        };
      };

      nixpkgs.config.allowUnfree = true;
    }

    # any other x86_64-linux should use `base` as a substituter & remote builder
    (lib.mkIf (config.networking.hostName != "base") {
      nix = {
        distributedBuilds = true;
        buildMachines = [
          {
            hostName = "base";
            system = "x86_64-linux";
            maxJobs = 1;
            speedFactor = 2;
            supportedFeatures = [ "nixos-test" "benchmark" "big-parallel" "kvm" ];
          }
        ];
        extraOptions = "builders-use-substitutes = true";
      };
    })
  ];
}
