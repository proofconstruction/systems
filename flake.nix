{
  inputs = {
    nixpkgs = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      ref = "nixpkgs-unstable";
    };

    nixos-hardware = {
      type = "github";
      owner = "nixos";
      repo = "nixos-hardware";
      ref = "master";
    };

    darwin = {
      type = "github";
      owner = "lnl7";
      repo = "nix-darwin";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      type = "github";
      owner = "Mic92";
      repo = "nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      type = "github";
      owner = "nix-community";
      repo = "emacs-overlay";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems-private.url = path:///home/alex/systems-private;

  };

  outputs =
    { self
    , nixpkgs
    , nixos-hardware
    , darwin
    , nix-index-database
    , home-manager
    , emacs-overlay
    , systems-private
    } @ inputs:
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
          modules = [{ custom.user.shell = nixpkgs.legacyPackages.x86_64-linux.bash; }];
        };

        pi = {
          system = "aarch64-linux";
          modules = [
            nixos-hardware.nixosModules.raspberry-pi-4
            { custom.user.shell = nixpkgs.legacyPackages.aarch64-linux.bash; }
          ];
        };
      };
    in
    {
      nixosConfigurations = nixpkgs.lib.mapAttrs mkNixosSystem nixosSystems;
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixpkgs-fmt;
    };
}

