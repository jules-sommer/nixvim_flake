{ pkgs, buildVimPlugin, ... }:
(buildVimPlugin {
  pname = "tokyonight-nvim";
  version = "2024-05-29";
  src = pkgs.fetchgit {
    name = "tokyonight-nvim";
    url = "git+file:///home/jules/000_dev/030_lua/tokyo-neon-night";
  };
})
