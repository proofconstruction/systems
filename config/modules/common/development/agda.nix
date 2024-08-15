{ config
, pkgs
, lib
, ...
}:

let
  myAgda = pkgs.agda.withPackages (p: [ p.standard-library ]);
in
{
  options.mine.development.agda.enable = lib.mkEnableOption "Agda devtools";

  config = lib.mkIf config.mine.development.agda.enable {
    home-manager.users.${config.mine.user.name}.home.packages = with pkgs; [
      myAgda
    ];
  };
}
