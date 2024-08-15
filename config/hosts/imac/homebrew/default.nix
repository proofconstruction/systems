{ config
, ...
}:

{
  config.homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
    casks = [
      "google-chrome"
      "emacs-mac"
      "gimp"
      "iina"
      "microsoft-edge"
    ];
    taps = [
      "railwaycat/emacsmacport"
    ];
  };
}
