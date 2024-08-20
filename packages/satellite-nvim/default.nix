{ pkgs, buildVimPlugin, ... }:
(buildVimPlugin {
  pname = "satellite-nvim";
  version = "2024-08-19";
  src = pkgs.fetchFromGitHub {
    owner = "lewis6991";
    repo = "satellite.nvim";
    rev = "777ed56";
    hash = "sha256-04Js+9SB4VuCq/ACbNh5BZcolu8i8vlGU72qo5xxfpk=";
  };
})
