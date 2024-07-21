run output="default":
  nix run .#{{output}}

show:
  nix flake show

check:
  nix flake check

build-home flake="xeta":
  home-manager switch --flake .#{{flake}}
