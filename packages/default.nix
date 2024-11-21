{ pkgs, ... }:
let
  inherit (pkgs.vimUtils) buildVimPlugin;
  inherit (pkgs.tree-sitter) buildGrammar;
in
{
  treesitter-nu = import ./treesitter-nu/default.nix { inherit pkgs buildGrammar; };
  vim-smartword = import ./vim-smartword/default.nix { inherit buildVimPlugin pkgs; };
  satellite-nvim = import ./satellite-nvim/default.nix { inherit pkgs buildVimPlugin; };
  tokyonight-nvim = import ./tokyonight-nvim/default.nix { inherit pkgs buildVimPlugin; };
  noice = import ./noice { inherit pkgs buildVimPlugin; };
}
