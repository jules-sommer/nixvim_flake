{ pkgs, ... }:
let
  inherit (pkgs.vimUtils) buildVimPlugin;
  inherit (pkgs.tree-sitter) buildGrammar;
in
{
  supermaven-nvim = import ./supermaven-nvim/default.nix { inherit pkgs buildVimPlugin; };
  treesitter-nu = import ./treesitter-nu/default.nix { inherit pkgs buildGrammar; };
  vim-smartword = import ./vim-smartword/default.nix { inherit buildVimPlugin pkgs; };
  satellite-nvim = import ./satellite-nvim/default.nix { inherit pkgs buildVimPlugin; };
}
