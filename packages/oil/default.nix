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
    rev = "dba037598843973b8c54bc5ce0318db4a0da439d";
    sha256 = "06b0j6vrih5nh5hw52vc55pywzi01m57v2r6p52p783aqbpp22p9";
    fetchSubmodules = true;
  };
  meta.homepage = "https://github.com/stevearc/oil.nvim/";
}
