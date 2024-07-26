{ pkgs, helpers, ... }:
let
  mkNeovimPlugin = helpers.mkNeovimPlugin;
  buildVimPlugin = pkgs.vimUtils.buildVimPlugin;
in
(buildVimPlugin {
  pname = "supermaven-nvim";
  version = "2024-05-29";
  src = pkgs.fetchFromGitHub {
    owner = "supermaven-inc";
    repo = "supermaven-nvim";
    rev = "264768c6b2a2e0480868e9dae443112e33b1484a";
    hash = "sha256-apbSGeqDJH2JHyf9ETDW0sn3pHecOkz7iZ9maBQ6zy4=";
  };
  meta.homepage = "https://github.com/supermaven-inc/supermaven-nvim";
})
