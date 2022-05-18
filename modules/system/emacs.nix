{ pkgs, emacs-overlay, ... }:

let
#  emacsWithPackages = (pkgs.emacsPackagesFor pkgs.emacs).emacsWithPackages;
  emacsWithPackages = (pkgs.emacsPackagesFor pkgs.emacsPgtkNativeComp).emacsWithPackages;
in
  emacsWithPackages (epkgs: (with epkgs.melpaStablePackages; [
    magit
  ] ++ (with epkgs.melpaPackages; [
    company
    counsel
    diminish
    direnv
    docker-tramp
    dockerfile-mode
    docker-compose-mode
    expand-region
    f
    haskell-mode
    ivy
    ivy-pass
    json-mode
    markdown-mode
    minimal-theme
    nix-mode
    nord-theme
    olivetti
    paren-face
    pass
    smartparens
    svelte-mode
    swiper
    typescript-mode
    use-package
    vue-mode
    visual-fill-column
    vterm
    which-key
    whitespace-cleanup-mode
    yaml-mode
  ]) ++ (with epkgs.elpaPackages; [
    auctex
    beacon
    js2-mode
    adaptive-wrap
    undo-tree
  ]) ++ [
    pkgs.mu
    pkgs.shellcheck
  ]))
