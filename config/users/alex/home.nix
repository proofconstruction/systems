{ config
, ...
}:

{
  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      users.${config.mine.user.name} = {
        home = {
          stateVersion = config.system.stateVersion;
          sessionVariables = {
            BROWSER = "firefox";
            LC_CTYPE = "en_US.UTF-8";
            PAGER = "less -R";
          };
        };
      };
    };
  };

  imports = [ ./email.nix ];
}
