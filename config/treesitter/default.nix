{
  config,
  pkgs,
  helpers,
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
      autoLoad = true;
      folding = true;

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
        auto_install = false;
        ensure_installed = "all";
        highlight = {
          additional_vim_regex_highlighting = true;
          custom_captures = { };
          disable = [
            "rust"
          ];
          enable = true;
        };
        ignore_install = [
          "rust"
        ];
        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = false;
            node_decremental = "grm";
            node_incremental = "grn";
            scope_incremental = "grc";
          };
        };
        indent = {
          enable = true;
        };
        parser_install_dir = helpers.mkRaw ''
          vim.fs.joinpath(vim.fn.stdpath('data'), 'treesitter')
        '';
        sync_install = false;
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
