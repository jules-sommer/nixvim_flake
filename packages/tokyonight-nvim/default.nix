{ pkgs, buildVimPlugin, ... }:
(buildVimPlugin {
  pname = "tokyonight-nvim";
  version = "2024-05-29";
  src = pkgs.fetchFromGitHub {
    # folke/tokyonight.nvim
    name = "tokyonight-nvim";

    owner = "folke";
    repo = "tokyonight.nvim";
    rev = "latest";
    hash = "sha256-04Js+9SB4VuCq/ACbNh5BZcolu8i8vlGU72qo5xxfpk=";

  };
})
