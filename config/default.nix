{
  lib,
  pkgs,
  helpers,
  system,
  inputs,
  ...
}:
with lib;
{
  imports = [
    ./autoCmds
    ./cmp
    ./colorscheme
    ./hop
    ./keymaps
    ./lsp
    ./mini
    ./noice
    ./notify
    ./oil
    ./satellite
    ./startup
    ./telescope
    ./treesitter
    ./undotree
    ./yanky
    ./extra-plugins.nix
    ./vim-opts.nix
  ];

  config = {
    colorschemes.tokyonight = enabled;
    nixpkgs = { inherit pkgs; };
    package = inputs.neovim-nightly.packages.${system}.default;

    lsp = enabled' {
      rustaceanvim = disabled;
      none-ls = disabled;
    };

    luaLoader = enabled;
    performance = {
      combinePlugins = enabled' {
        standalonePlugins = [
          "nvim-treesitter"
        ];
      };
      byteCompileLua = enablePred' helpers.enableExceptInTests {
        nvimRuntime = true;
        plugins = true;
      };
    };

    plugins = {
      oil = enabled;
      startup = enabled;
      telescope = enabled;
      yanky = enabled;
      ollama = enabled;
      noice = enabled;
      hop = enabled;
      treesitter = enablePred helpers.enableExceptInTests;
      cmp = enabled;
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
      have_nerd_font = true;
      bigfile_size = 1024 * 1024 * 3; # 3mb
    };

    diagnostics = {
      virtual_text = false;
      virtual_lines = true;
      signs = {
        text = [
          ""
          ""
          ""
          ""
        ];
      };
      float = {
        show_header = true;
        border = "rounded";
        suffix = "";
        focusable = false;
        enabled = false;
        source = "always";
        header = [
          "  Diagnostics"
          "String"
        ];
        prefix = helpers.mkRaw ''
          function(_, _, _)
            return "  ", "String"
          end
        '';
      };
      update_in_insert = false;
      underline = true;
      severity_sort = true;
    };

    plugins = {
      render-markdown = enabled' {
        settings = {
          debounce = 100;
          max_file_size = 20.0;
          injections = {
            gitcommit = enabled' {
              query = ''
                ((message) @injection.content
                    (#set! injection.combined)
                    (#set! injection.include-children)
                    (#set! injection.language "markdown"))
              '';
            };
          };
        };
      };
      web-devicons = enabled;
      fugitive = disabled;
      git-conflict = enabled' {
        settings = {
          default_commands = true;
          default_mappings = {
            both = "b";
            next = "n";
            none = "0";
            ours = "o";
            prev = "p";
            theirs = "t";
          };
          disable_diagnostics = false;
          highlights = {
            current = "DiffText";
            incoming = "DiffAdd";
          };
          list_opener = "copen";
        };
      };
      undotree = enabled;
      persistence = enabled;
      indent-blankline = enabled' {
        settings = {
          exclude = {
            buftypes = [
              "terminal"
              "quickfix"
            ];
            filetypes = [
              "startup"
            ];
          };

          # highlights for plugin set @ ./colorscheme/default.nix
          indent = {
            char = "┆";
            tab_char = "┆";
          };
          scope = {
            show_end = false;
            show_exact_scope = false;
            show_start = false;
          };
        };
      };

      sleuth = disabled;

      todo-comments = enabled' {
        settings = {
          signs = true;
        };
      };

      barbecue = enabled;
      rainbow-delimiters = enablePred' helpers.enableExceptInTests {
        strategy = {
          "" = "global";
          vim = "local";
        };
        query = {
          "" = "rainbow-delimiters";
          lua = "rainbow-blocks";
        };
        highlight = [
          "RainbowDelimiterRed"
          "RainbowDelimiterYellow"
          "RainbowDelimiterBlue"
          "RainbowDelimiterOrange"
          "RainbowDelimiterGreen"
          "RainbowDelimiterViolet"
          "RainbowDelimiterCyan"
        ];
      };

      better-escape = disabled;
      harpoon = disabled;
      ccc = disabled;
      floaterm = disabled;
      gitsigns = disabled;
      lazygit = enabled;
      transparent = enabled;
    };

  };
}
