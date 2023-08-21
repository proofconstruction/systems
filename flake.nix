{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;

    nixos.url = github:nixos/nixpkgs/nixos-unstable;

    nixos-hardware.url = github:nixos/nixos-hardware/master;

    nix-index-database = {
      url = github:Mic92/nix-index-database;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = github:nix-community/emacs-overlay;
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-anywhere = {
      url = gitlab:slotThe/emacs-anywhere;
      flake = false;
    };

    systems-private.url = git+ssh://git@github.com/proofconstruction/systems-private;
  };

  outputs =
    inputs @ { self
    , nixpkgs
    , nixos
    , nixos-hardware
    , nix-index-database
    , home-manager
    , emacs-overlay
    , emacs-anywhere
    , systems-private
    }:
    let
      mkNixosModules = name: [
        {
          networking.hostName = name;
          system.stateVersion = "23.11";
          programs.command-not-found.enable = false;
          nixpkgs.overlays = [ emacs-overlay.overlay ];
          home-manager.users.alex.home.file.".emacs.d/emacs-anywhere.el".source = "${emacs-anywhere.outPath}/emacs-anywhere.el";
        }
        home-manager.nixosModules.home-manager
        nix-index-database.nixosModules.nix-index
        systems-private.nixosModules.private
        ./config/hosts/${name}
        ./config
      ];

      # turn an attrset from nixosSystems into a nixosConfiguration
      mkNixosSystem = name: cfg: nixpkgs.lib.nixosSystem {
        system = cfg.system;
        modules = (mkNixosModules name) ++ (cfg.modules or [ ]);
        specialArgs = inputs;
      };

      # definitions for the systems I use
      nixosSystems = {
        base = {
          system = "x86_64-linux";
          modules = [ ];
        };

        carbon = {
          system = "x86_64-linux";
          modules = [
            nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen
          ];
        };

        mini = {
          system = "x86_64-linux";
          modules = [
            { mine.user.shell = nixpkgs.legacyPackages.x86_64-linux.bash; }
          ];
        };

        pi = {
          system = "aarch64-linux";
          modules = [
            nixos-hardware.nixosModules.raspberry-pi-4
            { mine.user.shell = nixpkgs.legacyPackages.aarch64-linux.bash; }
          ];
        };
      };
    in
    {
      nixosConfigurations = nixpkgs.lib.mapAttrs mkNixosSystem nixosSystems;
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}

