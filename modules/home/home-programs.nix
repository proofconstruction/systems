{ config, pkgs, home-manager, ...}:

{
  programs = {

    direnv = {
      enable = true;
      enableZshIntegration = true;
    };

    firefox = {
      enable = true;
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      userName = "alex";
      userEmail = "source@proof.construction";

      signing = {
        key = "BF3B0938F91BB15276E812D82A5A57FCA60B8BF9";
        signByDefault = true;
      };
    };

    home-manager.enable = true;

    htop = {
      enable = true;
      settings = {
        color_scheme = 5;
        tree_view = true;
      };
    };

    man.enable = true;

    rtorrent.enable = true;

    ssh.enable = true;

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      autocd = true;
      defaultKeymap = "emacs";
      dotDir = ".config/zsh";
      history = {
        extended = true;
        share = true;
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" ];
        theme = "lambda";
      };
    };
  };
}
