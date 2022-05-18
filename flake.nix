{
  description = "My system config";

  # To update all inputs:
  # $ nix flake update --recreate-lock-file
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, emacs-overlay, ... }@attrs:
    let
      hmModule = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.alex = {
          imports = [
            ./modules/home
          ];
        };
      };
    in {
      nixosConfigurations = {
        carbon = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = attrs;
          modules = [
            home-manager.nixosModules.home-manager hmModule
            ./hosts/carbon.nix
            nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen
          ];
        };

        pi = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = attrs;
          modules = [
            home-manager.nixosModules.home-manager hmModule
            ./hosts/carbon.nix
            nixos-hardware.nixosModules.raspberry-pi-4
          ];
        };
      };
    };
}
