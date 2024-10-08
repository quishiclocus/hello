{ fetchurl, stdenv, lib, makeWrapper, ... }:
let
  version = "nightly";
  binarySource = 
    let
      fetch = variant: sha256: builtins.fetchurl {
        inherit sha256;
        url = "https://github.com/neovim/neovim/releases/download/nightly/nvim-${variant}.tar.gz";
      };
    in
    {
      aarch64-darwin = fetch "macos-arm64" "dd0681fac15282d619e7b7694def7a8c76e4741441ffff5676538be125523dd8";
    };
in
stdenv.mkDerivation {
  inherit version;
  pname = "neovim";
  src = binarySource.${stdenv.system} or (builtins.throw "${stdenv.system} source not known");
  nativeBuilInputs = [  ];
  buildInputs = [  ];
  unpackPhase = ''
    tar xf $src
  '';
  installPhase = ''
    mkdir -p $out/
    cp -a nvim-macos-arm64/* $out/
  '';
}
