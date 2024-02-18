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
        gnomeExtensions.gtile
        gnomeExtensions.dash-to-dock
        gnomeExtensions.applications-overview-tooltip
        #gnomeExtensions.open-bar #When repos update to 24.05 remove these comments
        gnomeExtensions.blur-my-shell
        gnomeExtensions.compiz-windows-effect
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
            "light-style@gnome-shell-extensions.gcampax.github.com"
            "tophat@fflewddur.github.io"
            "just-perfection-desktop@just-perfection"
            "window-title-is-back@fthx"
            "drive-menu@gnome-shell-extensions.gcampax.github.com"
            "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
            "native-window-placement@gnome-shell-extensions.gcampax.github.com"
            "gTile@vibou"
            "pano@elhan.io"
            "eepresetselector@ulville.github.io"
            "blur-my-shell@aunetx"
          ];
        };
        "org/gnome/shell/extensions/blur-my-shell/panel" = { blur = false; };

        "org/gnome/mutter" = {
          attach-modal-dialogs = false;
          edge-tiling = true;
          overlay-key = "Super_L";
          workspaces-only-on-primary = false;
        };

        "keybindings" = {
          cancel-input-capture = [ "<Super><Shift>Escape" ];
          toggle-tiled-left = [ "<Super>Left" ];
          toggle-tiled-right = [ "<Super>Right" ];
        };

        "wayland/keybindings" = { restore-shortcuts = [ "<Super>Escape" ]; };

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
