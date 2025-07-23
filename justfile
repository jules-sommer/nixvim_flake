run output="default":
  nix run .#{{output}}

build output="default":
  nix build .#{{output}}

repl:
  nix repl --expr 'builtins.getFlake "'$(pwd)'"'

show:
  nix flake show

check:
  nix flake check
