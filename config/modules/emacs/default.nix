{ config
, lib
, pkgs
, ...
}:

let
  emacsVersion = pkgs.emacs-git;
  emacsWithPackages = (pkgs.emacsPackagesFor emacsVersion).emacsWithPackages;
  myEmacs = emacsWithPackages
    (epkgs: (with epkgs.melpaStablePackages; [
      magit
    ] ++ (with epkgs.melpaPackages; [
      company
      counsel
      diminish
      direnv
      dockerfile-mode
      expand-region
      f
      go-mode
      haskell-mode
      ivy
      ivy-pass
      json-mode
      leuven-theme
      lsp-haskell
      lsp-mode
      lsp-ui
      markdown-mode
      minimal-theme
      mood-line
      nix-mode
      nixpkgs-fmt
      nord-theme
      olivetti
      org-kanban
      paren-face
      pass
      ripgrep
      rust-mode
      rustic
      smartparens
      svelte-mode
      swiper
      terraform-mode
      typescript-mode
      use-package
      visual-fill-column
      vterm
      which-key
      whitespace-cleanup-mode
      yaml-mode
    ]) ++ (with epkgs.elpaPackages; [
      auctex
      beacon
      js2-mode
      pinentry
      adaptive-wrap
      undo-tree
      xclip
    ])));

  emacsConfig = builtins.readFile ./emacs.el;
in
{
  options.mine.emacs = with lib; {
    enable = mkEnableOption "emacs";
    package = mkOption {
      type = types.package;
      default = myEmacs;
      example = pkgs.emacs-nox;
      description = "Which Emacs to enable.";
    };
    configText = mkOption {
      type = types.str;
      default = emacsConfig;
      description = ".emacs source";
    };
    configExtra = mkOption {
      type = types.listOf types.str;
      default = [ ];
      description = "Additional configuration to append to .emacs";
    };
  };

  config = lib.mkIf config.mine.emacs.enable {
    environment.pathsToLink = [ "/share/emacs" ];
    services.emacs = {
      enable = true;
      package = myEmacs;
      defaultEditor = true;
      install = true;
    };

    home-manager.users.${config.mine.user.name} = {
      programs.emacs = {
        enable = true;
        package = myEmacs;
      };

      home.file.".emacs".text = lib.concatLines ([
        config.mine.emacs.configText
      ] ++ config.mine.emacs.configExtra);
    };
  };
}
