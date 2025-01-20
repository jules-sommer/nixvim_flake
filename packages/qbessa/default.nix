{ pkgs, buildVimPlugin, ... }:
(buildVimPlugin {
  pname = "qbessa";
  version = "2025-01-20";
  src = pkgs.fetchFromGitHub {
    #https://github.com/sgraham/qbessa.vim
    owner = "sgraham";
    repo = "qbessa.vim";
    rev = "30ba219";
    hash = "sha256-i+ppI7cEnLhlK1p0EHw6aR7Ljw1ay3Fs/7IDF4sp7pM=";
  };
})
