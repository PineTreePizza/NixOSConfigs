{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  name = "wallpapers";
  src = pkgs.fetchgit {
    url = "https://github.com/PineTreePizza/WallpapersNix";
    sha256 = "sha256-0r0q1y6CBdnLfSgyOrdzbP+nVz9ufIzXeNbgaDJvTBs=";
  };
  installPhase = ''
    mkdir -p $out/share/wallpapers
    cp -r $src/* $out/share/wallpapers
  '';
}
