{ config
, lib
, pkgs
, ...
}:

let
  cfgp = config.private;
in
{
  options.mine.user = with lib; {
    enable = mkOption {
      type = types.bool;
      default = true;
      description = "This host will be configured with my standard user account.";
    };

    name = mkOption {
      type = types.str;
      default = "alex";
    };

    fullName = mkOption {
      type = types.str;
      default = cfgp.personal.fullName;
    };

    shell = mkOption {
      type = types.package;
      default = pkgs.zsh;
      description = "The default user shell is zsh.";
    };

    sshPublicKey = mkOption {
      type = types.str;
      description = "This user's SSH public key.";
      default = cfgp.personal.sshPublicKey;
    };
  };

  imports = [
    ./alex/default.nix
  ];
}
