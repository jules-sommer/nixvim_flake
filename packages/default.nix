{ pkgs, ... }:
let
  inherit (pkgs.vimUtils) buildVimPlugin;
  inherit (pkgs.tree-sitter) buildGrammar;
in
{
  vim-smartword = import ./vim-smartword/default.nix { inherit buildVimPlugin pkgs; };
  satellite-nvim = import ./satellite-nvim/default.nix { inherit pkgs buildVimPlugin; };
}
