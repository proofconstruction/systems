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
      emacsOverlay = { nixpkgs.overlays = [ emacs-overlay.overlay ]; };

      mkCommonModules = name: [
        ./config/hosts/${name}
        ./config/modules/common
        ./config/users
        ./config/roles
        {
          networking.hostName = name;
          system.stateVersion = "24.05";
          programs.command-not-found.enable = false; # use nix-index-database
        }
      ];

      nixosModules = [
        home-manager.nixosModules.home-manager
        nix-index-database.nixosModules.nix-index
        systems-private.nixosModules.private
        ./config/modules/nixos
      ];

      darwinModules = [
        home-manager.darwinModules.home-manager
        nix-index-database.darwinModules.nix-index
        systems-private.nixosModules.private
        ./config/modules/darwin
      ];

      # check if attrset should become a nixosConfiguration
      isNixosSystem = system: system == "x86_64-linux";

      # generate the list of modules to inject into the configuration
      mkModules = name: cfg:
        (mkCommonModules name)
        ++ (if isNixosSystem cfg.system
        then nixosModules
        else darwinModules)
        ++ (cfg.modules or [ ]);

      mkSystem = name: cfg: {
        system = cfg.system;
        modules = mkModules name cfg;
        specialArgs = {
          inherit inputs;
        };
      };

      # turn a named attrset into nixosSystems or darwinSystems
      mkConfiguration = name: cfg:
        if isNixosSystem cfg.system
        then nixpkgs.lib.nixosSystem (mkSystem name cfg)
        else darwin.lib.darwinSystem (mkSystem name cfg);

      mkConfigurations = systems: nixpkgs.lib.mapAttrs mkConfiguration systems;
      darwinSystems = {
        imac = {
          system = "aarch64-darwin";
          modules = [ emacsOverlay ];
        };
      };

      nixosSystems = {
        base = {
          system = "x86_64-linux";
          modules = [ ];
        };

        carbon = {
          system = "x86_64-linux";
          modules = [
            nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen
            emacsOverlay
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
      darwinConfigurations = mkConfigurations darwinSystems;
      nixosConfigurations = mkConfigurations nixosSystems;
    };
}

