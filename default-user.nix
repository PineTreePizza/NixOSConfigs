{ pkgs, ... }:
let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
  defaultConfig = import ./default-user.nix { inherit pkgs; };
in {
  # The home.stateVersion option does not have a default and must be set
  home.stateVersion = "23.11";
  # Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ];
  programs.git = {
    enable = true;
    userName = "PineTreePizza";
    userEmail = "pinetreeonpizza@gmail.com";
  };
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "GoogleDot-White";
      package = pkgs.google-cursor;
      size = 24;
    };
    theme = {
      #name = "Flat-Remix-GTK-Blue-Light-Solid";
      #package = pkgs.flat-remix-gtk;
      package = pkgs.adw-gtk3;
      name = "adw-gtk3";
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=0
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=0
      '';
    };
  };
  home.packages = with pkgs; [ gnomeExtensions.user-themes colloid-gtk-theme ];
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      favorite-apps = [
        "firefox.desktop"
        "emacs.desktop"
        "code.desktop"
        "com.raggesilver.BlackBox.desktop"
        "org.gnome.Nautilus.desktop"
        "github-desktop.desktop"
        "org.gnome.gitg.desktop"
        "discord.desktop"
        "steam.desktop"
        "gnome-system-monitor.desktop"
        "org.gnome.design.Contrast.desktop"
        "gimp.desktop"
        "org.telegram.desktop.desktop"
        "com.mattjakeman.ExtensionManager.desktop"
        "org.remmina.Remmina.desktop"
        "org.gnome.Settings.desktop"
      ];
    };
    "org/gnome/shell/extensions/user-theme" = { name = "Colloid"; };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-light";
      enable-hot-corners = true;
    };

    "org/gnome/desktop/input-sources" = {
      mru-sources = [([ "xkb" "us" ])];
      sources = [ ([ "xkb" "us" ]) ([ "xkb" "ru" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" ];
    };

    "org/gnome/desktop/wm/preferences" = { workspace-names = [ "Main" ]; };
    "org/gnome/desktop/background" = {
      picture-uri =
        "file:///run/current-system/sw/share/wallpapers/WhiteRoom.png";
      picture-uri-dark =
        "file:///run/current-system/sw/share/wallpapers/WhiteRoom.png";
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri =
        "file:///run/current-system/sw/share/wallpapers/WhiteRoom.png";
      primary-color = "#00aaff";
      secondary-color = "#FAFAFA";
    };
  };
}
