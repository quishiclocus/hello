final: prev: {
  hello = final.writeShellScriptBin "hello" ''
    ${prev.hello}/bin/hello -g "hellorld" "$@"
  '';
}
