{ config, pkgs, lib, ... }:
let
  home-manager = builtins.fetchTarball
    "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  defaultConfig = import ./default-user.nix { inherit pkgs; };
in {
  imports = [ (import "${home-manager}/nixos") ];

  home-manager.users.pong =
    lib.mkMerge [ defaultConfig { home.packages = with pkgs; [ ]; } ];
  #services.dropbox.enable = true;
  home-manager.useGlobalPkgs = true;
  programs.dconf.enable = true;
}
