{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "wallpapers";
  src = pkgs.fetchgit {
    url = "https://github.com/PineTreePizza/WallpapersNix";
    sha256 = "sha256-cjb2bClHB08yJRDgwf823AeF0joZUuq3zF/ANI5Mcs0=";
  };
  installPhase = ''
    mkdir -p $out/share/wallpapers
    cp -r $src/* $out/share/wallpapers
  '';
}
