{ config
, lib
, pkgs
, ...
}:

let
  mailAccounts = config.private.email;

  mkAccounts = name: cfg: {
    primary = if name == "primary" then true else false;
    flavor = cfg.flavor;
    realName = cfg.fullName;
    address = cfg.address;
    passwordCommand = cfg.passwordCommand;
    mu.enable = true;
    msmtp.enable = true;
    mbsync = {
      enable = true;
      create = "maildir";
      expunge = "both";
      remove = "both";
    };
  };
in
{
  config.home-manager.users.${config.mine.user.name} = {
    programs = {
      mbsync.enable = true;
      msmtp.enable = true;
      mu.enable = true;
    };
    services = {
      mbsync = {
        enable = true;
        postExec = "${pkgs.mu}/bin/mu index";
      };
    };

    accounts.email = {
      maildirBasePath = "mail";
      accounts = lib.mapAttrs mkAccounts mailAccounts;
    };
  };
}
