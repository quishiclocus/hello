{ makeScope, newScope, writeShellScriptBin }: makeScope newScope (self: {
  meow = writeShellScriptBin "meow" ''
    echo meow
  '';
  meow2 = writeShellScriptBin "meow2" ''
    echo "meow is at ${self.meow}"
  '';
})
