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
      aarch64-darwin = fetch "macos-arm64" "f37b379a0fc0393b8bc59c78ca1f84f8713ec6a9478dc94c39d81e3df6b43006";
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
