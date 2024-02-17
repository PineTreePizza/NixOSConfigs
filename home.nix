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
        gnomeExtensions.burn-my-windows
        gnomeExtensions.tophat
        
      ];

      dconf.settings = {
        # `gnome-extensions list` for a list
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = [
            "user-theme@gnome-shell-extensions.gcampax.github.com"
            "burn-my-windows@schneegans.github.com"
            "compiz-windows-effect@hermes83.github.com"
            "dash-to-dock@micxgx.gmail.com"
            "tophat@fflewddur.github.io"
            "just-perfection-desktop@just-perfection"
            "window-title-is-back@fthx"
            "drive-menu@gnome-shell-extensions.gcampax.github.com"
            "native-window-placement@gnome-shell-extensions.gcampax.github.com"
            "gTile@vibou"
            "pano@elhan.io"
            "blur-my-shell@aunetx"
          ];
        };
        "org/gnome/shell/extensions/blur-my-shell/panel" = {
          blur = false;
        };
        "org/gnome/shell/extensions/com/github/hermes83/compiz-windows-effect" = {
          mass = 80.0;
          speedup-factor-divider = 2.0;
          spring-k = 2.7;
        };
      };
    }
  ];
  home-manager.useGlobalPkgs = true;
  programs.dconf.enable = true;
}
