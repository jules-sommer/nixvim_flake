{
  lib,
  helpers,
  plugins,
  ...
}:
let
  inherit (lib)
    enablePred
    enablePred'
    enabled
    disabled
    enabled'
    ;
in
{
  imports =
    [
      ./autoCmds
      ./cmp
      ./colorscheme
      ./hop
      ./indent
      ./keymaps
      ./lsp
      ./markdown
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
    ]
    ++ [
      ./vim-opts.nix
    ];

  config = {
    # settings for this flake's implementation of nixvim
    colorschemes = {
      tokyonight = {
        enable = true;
        settings = {
          style = "night";
          transparent = true;
          styles = {
            comments = {
              italic = false;
            };
            # floats = "dark";
            # functions = { };
            keywords = {
              italic = false;
            };
            # sidebars = "dark";
            # variables = { };
          };
          sidebars = [
            "qf"
            "help"
            "undotree"
          ];
        };
      };
    };

    luaLoader = enabled;
    performance = {
      combinePlugins = {
        enable = false;
        standalonePlugins = with plugins; [
          nvim-treesitter
          oil-nvim
          conform-nvim
        ];
      };

      byteCompileLua = enablePred' helpers.enableExceptInTests {
        nvimRuntime = true;
        plugins = true;
      };
    };

    # Setting options defined in local flake modules
    modules = {
      lsp = enabled' {

      };

      mini = {
        animate = disabled;
        completion = disabled;
        ai_textobjs = enabled;
        base16 = disabled;
      };
    };

    plugins = {
      oil = enabled;
      startup = enabled;
      telescope = enabled;
      yanky = enabled;
      ollama = disabled;
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
      virtual_text = true;
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
      undotree = enabled;
      # persistence = enabled;
      barbecue = enabled;
      transparent = enabled;
      git-conflict = {
        enable = false;
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

      todo-comments = {
        enable = true;
        settings = {
          signs = true;
        };
      };

      rainbow-delimiters = {
        enable = true;
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
    };

    extraPlugins = [
      plugins.nvim-lspconfig
      plugins.nvim-various-textobjs
      plugins.nvim-treesitter-textsubjects
      plugins.satellite-nvim
      plugins.qbessa
      plugins.vim-wordmotion
      plugins.vim-smartword
      plugins.telescope-file-browser-nvim
    ];
  };
}
