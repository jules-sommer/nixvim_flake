{ pkgs, buildVimPlugin, ... }:
(buildVimPlugin {
  pname = "vim-smartword";
  version = "2024-08-06";
  src = pkgs.fetchFromGitHub {
    owner = "anuvyklack";
    repo = "vim-smartword";
    rev = "d171f92a545fa92ed983aef7d3862d2b59261f59";
    hash = "sha256-Kx1n3Obv01tFsLSl5gemFsGvbNkvWPX7E/x3/opD7hs=";
  };
})
