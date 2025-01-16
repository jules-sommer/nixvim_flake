{ pkgs, buildVimPlugin, ... }:
let
  inherit (pkgs) fetchFromGitHub;
in

buildVimPlugin {
  pname = "oil.nvim";
  version = "2024-12-14";
  src = fetchFromGitHub {
    owner = "stevearc";
    repo = "oil.nvim";
    rev = "09fa1d2";
    sha256 = "sha256-p8D5TKZuMWUW2/1OJ2a3isl/Fmwq3TZ6FpREyIzUImQ=";
    fetchSubmodules = true;
  };
  meta.homepage = "https://github.com/stevearc/oil.nvim/";
}
