{ pkgs, buildGrammar, ... }:
(buildGrammar {
  version = "0.0.1";
  language = "nu";
  src = pkgs.fetchFromGitHub {
    owner = "nushell";
    repo = "tree-sitter-nu";
    rev = "0bb9a602d9bc94b66fab96ce51d46a5a227ab76c";
    hash = "sha256-A5GiOpITOv3H0wytCv6t43buQ8IzxEXrk3gTlOrO0K0=";
  };
})
