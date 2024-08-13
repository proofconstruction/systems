{ config
, lib
, pkgs
, ...
}:

let
  emacsVersion = pkgs.emacs-git;
  emacsWithPackages = (pkgs.emacsPackagesFor emacsVersion).emacsWithPackages;

  melpaStablePkgs = epkgs: with epkgs.melpaStablePackages; [
    magit
  ];

  melpaUnstablePkgs = epkgs: with epkgs.melpaPackages; [
    # agda-mode
    company
    counsel
    diminish
    direnv
    dockerfile-mode
    expand-region
    f
    github-theme
    go-mode
    haskell-mode
    htmlize
    ivy
    ivy-pass
    json-mode
    leuven-theme
    lsp-haskell
    lsp-mode
    lsp-ui
    magit-delta
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
    wgrep
    which-key
    whitespace-cleanup-mode
    yaml-mode
    ztree
  ];

  elpaPkgs = epkgs: with epkgs.elpaPackages; [
    auctex
    beacon
    js2-mode
    pinentry
    adaptive-wrap
    undo-tree
    xclip
  ];

  ePkgs = epkgs: with epkgs; [
    mu4e
  ];

  pkgSetFns = [ melpaStablePkgs melpaUnstablePkgs elpaPkgs ePkgs ];

  # given epkgs and a function `epkgs: with epkgs.<pkgSet>; [ <pkgNames> ];`,
  # apply the function to epkgs
  applyPkgSetFn = arg: pkgSetFn: (pkgSetFn arg);

  # given epkgs and a list of functions of the above type,
  # apply each of the functions to epkgs and concat the results together
  mkWithPkgs = pkgsArg: pkgSetFns: lib.lists.concatMap (applyPkgSetFn pkgsArg) pkgSetFns;

  withPkgs = epkgs: mkWithPkgs epkgs pkgSetFns;

  languageServers = with pkgs; [
    nil # nix language server
    pyright # python language server
  ];

  systemPackages = with pkgs; [
    delta
  ];

in
{
  config = {
    mine.emacs.package = emacsWithPackages withPkgs;
    home-manager.users.${config.mine.user.name}.home.packages = languageServers ++ systemPackages;
  };
}
