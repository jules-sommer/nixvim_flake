{ pkgs, buildVimPlugin, ... }:
(buildVimPlugin {
  pname = "noice";
  version = "2024-11-21";
  src = pkgs.fetchFromGitHub {
    owner = "folke";
    repo = "noice.nvim";
    rev = "481059e08198298a52067ac48a334262f117e355";
    hash = "sha256-gyhefqPxOVBmNeKPW6d0i6f5OQyd6cy1lZsYqwpcH2c=";
  };
})
