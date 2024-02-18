{ pkgs, ... }:

{
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
      name = "Papirus-Light";
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
        "com.raggesilver.BlackBox.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };
    "org/gnome/shell/extensions/user-theme" = { name = "Colloid-Light"; };
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-light";
      enable-hot-corners = true;
    };
    "org/gnome/desktop/wm/preferences" = { workspace-names = [ "Main" ]; };
    "org/gnome/desktop/background" = {
      picture-uri =
        "file:///run/current-system/sw/share/wallpapers/wallpaper.png";
      picture-uri-dark =
        "file:///run/current-system/sw/share/wallpapers/wallpaper.png";
    };
    "org/gnome/desktop/screensaver" = {
      picture-uri =
        "file:///run/current-system/sw/share/wallpapers/wallpaper.png";
      primary-color = "#00aaff";
      secondary-color = "#FAFAFA";
    };
  };
}
