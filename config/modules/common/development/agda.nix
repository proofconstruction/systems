{ config
, pkgs
, lib
, ...
}:

let
  myAgda = pkgs.agda.withPackages (p: [ p.standard-library ]);
in
{
  options.custom.development.agda.enable = lib.mkEnableOption "Agda devtools";

  config = lib.mkIf config.custom.development.agda.enable {
    home-manager.users.${config.custom.user.name}.home.packages = with pkgs; [
      myAgda
    ];
  };
}
