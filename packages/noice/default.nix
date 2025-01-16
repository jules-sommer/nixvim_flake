{ pkgs, buildVimPlugin, ... }:
(buildVimPlugin {
  pname = "noice";
  version = "2025-01-16";
  src = pkgs.fetchFromGitHub {
    owner = "folke";
    repo = "noice.nvim";
    rev = "eaed6cc";
    hash = "sha256-OpwgNTGunmy6Y7D/k0T+DFK/WJ8MeVTGWwjiPTQlvEY=";
  };
})
