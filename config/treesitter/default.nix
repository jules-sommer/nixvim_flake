{
  config,
  pkgs,
  lib,
  ...
}:
let
  inherit (lib) mkIf enabled;
  cfg = config.plugins.treesitter;
in
{
  config = mkIf cfg.enable {
    plugins.treesitter = {
      # vim, regex, lua, bash, markdown, markdown_inline
      nixGrammars = true;
      nixvimInjections = true;

      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        json
        lua
        make
        markdown
        ziggy
        ziggy_schema
        nix
        regex
        toml
        vim
        vimdoc
        xml
        yaml
      ];

      settings = {
        auto_install = true;
        indent = {
          enable = true;
        };
      };
    };

    plugins.treesitter-textobjects = {
      enable = true;
      lspInterop = {
        enable = true;
        border = "rounded";
      };
      move = enabled;
      swap = enabled;
      select = enabled;
    };
  };
}
