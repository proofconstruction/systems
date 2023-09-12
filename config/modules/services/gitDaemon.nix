{ config
, lib
, pkgs
, ...
}:

let
  gitUser = "git";
  gitRoot = "/home/git";
  gitPort = 9418;
in
{
  options.mine.gitDaemon.enable = lib.mkEnableOption "gitDaemon";

  config = lib.mkIf config.mine.gitDaemon.enable {
    services = {
      gitDaemon = {
        enable = true;
        basePath = gitRoot;
        repositories = [
          gitRoot
        ];
        exportAll = true;
        listenAddress = "0.0.0.0";
        port = gitPort;
      };
    };

    users.users.${gitUser} = {
      createHome = true;
      home = gitRoot;
      shell = "${pkgs.gitFull}/bin/git-shell";
      openssh.authorizedKeys.keys = [ config.mine.user.sshPublicKey ];
    };

    # make sure we can git clone with ssh
    networking.firewall.allowedTCPPorts = [
      80
      443
      gitPort
    ];
  };
}
