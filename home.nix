{ config, pkgs, lib, ... }:
let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
  defaultConfig = import ./default-user.nix { inherit pkgs; };
in {
  imports = [ (import "${home-manager}/nixos") ];

  home-manager.users.pong = lib.mkMerge [
    defaultConfig
    {
      home.packages = with pkgs; [
        gnomeExtensions.user-themes
        gnomeExtensions.window-title-is-back
        gnomeExtensions.pano
        gnomeExtensions.dash-to-dock
        gnomeExtensions.tiling-assistant
        gnomeExtensions.applications-overview-tooltip
        #gnomeExtensions.open-bar #When repos update to 24.05 remove these comments
        gnomeExtensions.blur-my-shell
        gnomeExtensions.compiz-windows-effect
        gnomeExtensions.lock-keys
        gnomeExtensions.wifi-qrcode
        gnomeExtensions.just-perfection
        gnomeExtensions.easyeffects-preset-selector
        gnomeExtensions.tophat
        paper-gtk-theme
      ];

      dconf.settings = {
        # `gnome-extensions list` for a list
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = [
            "user-theme@gnome-shell-extensions.gcampax.github.com"
            "compiz-windows-effect@hermes83.github.com"
            "dash-to-dock@micxgx.gmail.com"
            "applications-overview-tooltip@RaphaelRochet"
            "wifiqrcode@glerro.pm.me"
            "tiling-assistant@leleat-on-github"
            "light-style@gnome-shell-extensions.gcampax.github.com"
            "tophat@fflewddur.github.io"
            "just-perfection-desktop@just-perfection"
            "lockkeys@vaina.lt"
            "window-title-is-back@fthx"
            "blur-my-shell@aunetx"
            "drive-menu@gnome-shell-extensions.gcampax.github.com"
            "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
            "native-window-placement@gnome-shell-extensions.gcampax.github.com"
            "pano@elhan.io"
            "eepresetselector@ulville.github.io"
          ];
        };

        "org/gnome/shell/extensions/blur-my-shell" = {
          color-and-noise = true;
          noise-lightness = 0.0;
        };

        "org/gnome/desktop/wm/keybindings" = {
          close = [ "<Super><Shift>q" ];
          maximize = [ ];
          move-to-monitor-down = [ "<Super><Shift>Down" ];
          move-to-monitor-left = [ ];
          move-to-monitor-right = [ ];
          move-to-monitor-up = [ "<Super><Shift>Up" ];
          move-to-workspace-1 = [ "<Super><Shift>1" ];
          move-to-workspace-10 = [ "<Super><Shift>0" ];
          move-to-workspace-2 = [ "<Super><Shift>2" ];
          move-to-workspace-3 = [ "<Super><Shift>3" ];
          move-to-workspace-4 = [ "<Super><Shift>4" ];
          move-to-workspace-5 = [ "<Super><Shift>5" ];
          move-to-workspace-6 = [ "<Super><Shift>6" ];
          move-to-workspace-7 = [ "<Super><Shift>7" ];
          move-to-workspace-8 = [ "<Super><Shift>8" ];
          move-to-workspace-9 = [ "<Super><Shift>9" ];
          move-to-workspace-down = [ "<Control><Shift><Alt>Down" ];
          move-to-workspace-left = [ "<Shift><Control><Super>Left" ];
          move-to-workspace-right = [ "<Shift><Control><Super>Right" ];
          move-to-workspace-up = [ "<Control><Shift><Alt>Up" ];
          switch-applications = [ "<Super>Tab" "<Alt>Tab" ];
          switch-applications-backward =
            [ "<Shift><Super>Tab" "<Shift><Alt>Tab" ];
          switch-group = [ "<Super>Above_Tab" "<Alt>Above_Tab" ];
          switch-group-backward =
            [ "<Shift><Super>Above_Tab" "<Shift><Alt>Above_Tab" ];
          switch-to-workspace-1 = [ "<Super>1" ];
          switch-to-workspace-10 = [ "<Super>0" ];
          switch-to-workspace-2 = [ "<Super>2" ];
          switch-to-workspace-3 = [ "<Super>3" ];
          switch-to-workspace-4 = [ "<Super>4" ];
          switch-to-workspace-5 = [ "<Super>5" ];
          switch-to-workspace-6 = [ "<Super>6" ];
          switch-to-workspace-7 = [ "<Super>7" ];
          switch-to-workspace-8 = [ "<Super>8" ];
          switch-to-workspace-9 = [ "<Super>9" ];
          switch-to-workspace-down = [ "<Control><Alt>Down" ];
          switch-to-workspace-last = [ "<Super>End" ];
          switch-to-workspace-left = [ "<Shift><Super>Left" ];
          switch-to-workspace-right = [ "<Shift><Super>Right" ];
          switch-to-workspace-up = [ "<Control><Alt>Up" ];
          unmaximize = [ ];

        };
        "org/gnome/shell/extensions/tiling-assistant" = {
          active-window-hint = 1;
          default-move-mode = 1;
          dynamic-keybinding-behavior = 3;
          last-version-installed = 44;
          maximize-with-gap = true;
          restore-window = [ "<Super>r" ];
          search-popup-layout = [ ];
          tile-bottom-half = [ "<Super>Down" ];
          tile-left-half = [ "<Super>Left" ];
          tile-maximize = [ "<Super>w" ];
          tile-right-half = [ "<Super>Right" ];
          tile-top-half = [ "<Super>Up" ];
          tile-topright-quarter-ignore-ta = [ ];
          tiling-popup-all-workspace = false;
          toggle-always-on-top = [ ];
          activate-layout0 = [ "<Shift><Super>t" ];
          auto-tile = [ ];
          enable-advanced-experimental-features = true;
          toggle-tiling-popup = [ ];
          show-layout-panel-indicator = false;
          single-screen-gap = 4;
          screen-bottom-gap = 10;
          screen-left-gap = 10;
          screen-right-gap = 10;
          screen-top-gap = 4;
          window-gap = 10;
        };

        "org/gnome/shell/extensions/blur-my-shell/applications" = {
          blur-on-overview = true;
        };

        "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
          blur = false;
        };

        "org/gnome/shell/extensions/blur-my-shell/dash-to-panel" = {
          blur-original-panel = false;
        };

        "org/gnome/shell/extensions/blur-my-shell/lockscreen" = {
          customize = true;
          sigma = 5;
        };

        "org/gnome/shell/extensions/blur-my-shell/overview" = {
          brightness = 0.57;
          color = [ (0.0) (0.0) (0.0) (0.0) ];
          customize = true;
          noise-amount = 0.0;
          noise-lightness = 0.0;
          sigma = 5;
        };

        "org/gnome/shell/extensions/blur-my-shell/panel" = {
          blur = true;
          brightness = 1.0;
          color = [ (1.0) (1.0) (1.0) (1.0) ];
          customize = true;
          noise-amount = 0.0;
          noise-lightness = 0.0;
          override-background-dynamically = true;
          sigma = 36;
          static-blur = true;
          style-panel = 1;
        };

        "org/gnome/mutter" = {
          attach-modal-dialogs = false;
          dynamic-workspaces = false;
          edge-tiling = true;
          overlay-key = "Super_L";
          workspaces-only-on-primary = false;
        };

        "org/gnome/mutter/keybindings" = {
          cancel-input-capture = [ "<Super><Shift>Escape" ];
          toggle-tiled-left = [ ];
          toggle-tiled-right = [ ];
        };

        "org/gnome/mutter/wayland/keybindings" = {
          restore-shortcuts = [ "<Super>Escape" ];
        };

        "org/gnome/shell/extensions/com/github/hermes83/compiz-windows-effect" =
          {
            mass = 80.0;
            speedup-factor-divider = 2.0;
            spring-k = 2.7;
          };

        "org/gnome/shell/extensions/window-title-is-back" = {
          colored-icon = false;
          icon-size = 20;
          show-app = true;
          show-icon = false;
          show-title = false;
        };
        "org/gnome/shell/extensions/just-perfection" = {
          accessibility-menu = true;
          activities-button = true;
          animation = 1;
          background-menu = true;
          calendar = true;
          clock-menu = true;
          controls-manager-spacing-size = 0;
          dash = true;
          dash-app-running = true;
          dash-icon-size = 32;
          dash-separator = true;
          double-super-to-appgrid = true;
          events-button = false;
          keyboard-layout = true;
          osd = true;
          osd-position = 2;
          panel = true;
          panel-in-overview = true;
          panel-notification-icon = true;
          power-icon = true;
          quick-settings = true;
          ripple-box = true;
          screen-sharing-indicator = true;
          search = true;
          show-apps-button = true;
          startup-status = 1;
          theme = false;
          top-panel-position = 0;
          weather = true;
          window-demands-attention-focus = false;
          window-picker-icon = true;
          window-preview-caption = true;
          window-preview-close-button = true;
          workspace = true;
          workspace-background-corner-size = 0;
          workspace-peek = true;
          workspace-popup = true;
          workspace-switcher-should-show = false;
          workspace-wrap-around = false;
          workspaces-in-app-grid = true;
          world-clock = false;
        };

      };
    }
  ];
  # services.dropbox.enable = true;
  home-manager.useGlobalPkgs = true;
  programs.dconf.enable = true;
}
