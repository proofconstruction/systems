{ config
, ...
}:

{
  config = {
    system = {
      defaults = {
        # Trackpad
        trackpad = {
          Clicking = true;
          TrackpadThreeFingerDrag = true;
        };

        # Firewall
        alf = {
          globalstate = 1;
          allowsignedenabled = 1;
          allowdownloadsignedenabled = 1;
          stealthenabled = 1;
        };

        # Dock
        dock = {
          autohide = true;
          expose-group-by-app = false;
          mru-spaces = false;
          show-recents = false;
          tilesize = 48;
        };

        # Finder
        finder = {
          AppleShowAllFiles = true;
          CreateDesktop = false;
          FXDefaultSearchScope = "SCcf";
          FXEnableExtensionChangeWarning = false;
          FXPreferredViewStyle = "Nlsv";
          QuitMenuItem = true;
          ShowPathbar = true;
          ShowStatusBar = true;
          _FXShowPosixPathInTitle = true;
        };

        # Application defaults
        NSGlobalDomain = {
          AppleMeasurementUnits = "Centimeters";
          AppleShowScrollBars = "WhenScrolling";
          AppleTemperatureUnit = "Celsius";
          AppleEnableSwipeNavigateWithScrolls = true;
          AppleICUForce24HourTime = true;
          AppleInterfaceStyleSwitchesAutomatically = false;
          AppleShowAllExtensions = true;
          AppleShowAllFiles = true;
          NSAutomaticCapitalizationEnabled = false;
          NSAutomaticPeriodSubstitutionEnabled = false;
          NSAutomaticSpellingCorrectionEnabled = false;
          _HIHideMenuBar = true;
        };

        # Login
        loginwindow = {
          GuestEnabled = false;
        };
      };

      # Keyboard
      keyboard = {
        enableKeyMapping = true;
        remapCapsLockToControl = true;
      };

      stateVersion = 4;
    };
  };
}
