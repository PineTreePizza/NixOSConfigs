{ pkgs, ... }:

{
  # The home.stateVersion option does not have a default and must be set
  home.stateVersion = "24.05";
  # Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ];
  programs.git = {
    enable = true;
    userName = "PineTreePizza";
    userEmail = "pinetreeonpizza@gmail.com";
  };
  # gtk = {
  #   enable = true;
  #   iconTheme = {
  #     name = "Papirus;
  #     package = pkgs.papirus-icon-theme;
  #   };
  #   cursorTheme = {
  #     name = "GoogleDot-Black";
  #     package = pkgs.google-cursor;
  #     size = 24;
  #   };
  #   theme = {
  #     name = "Flat-Remix-GTK-Blue-Light-Solid";
  #     package = pkgs.flat-remix-gtk;
  #     #package = pkgs.adw-gtk3;
  #     #name = "adw-gtk3";
  #   };
  #   gtk3.extraConfig = {
  #     Settings = ''
  #       gtk-application-prefer-dark-theme=0
  #     '';
  #   };

  #   gtk4.extraConfig = {
  #     Settings = ''
  #       gtk-application-prefer-dark-theme=0
  #     '';
  #   };
  # };
  # home.packages = with pkgs; [ colloid-gtk-theme ];
}
