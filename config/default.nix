{
  lib,
  pkgs,
  helpers,
  config,
  plugins,
  theme,
  ...
}:
with lib;
{
  imports = [
    ./colorscheme
    ./yanky
    ./lsp
    ./hop
    ./cmp
    ./telescope
    ./treesitter
    ./startup
    ./oil
    ./undotree
    ./autoCmds
    ./satellite
    ./keymaps
    ./mini
    ./noice
  ];

  config = {
    # settings for this flake's implementation of nixvim
    colorschemes = {
      tokyonight.enable = true;
      rose-pine.enable = false;
      kanagawa.enable = false;
    };

    lsp = {
      enable = true;
      rustaceanvim = enabled;
      none-ls = enabled;
    };
    # vim.loader.enable
    luaLoader = enabled;
    performance = {
      combinePlugins = {
        enable = true;
        standalonePlugins = [
          "nvim-treesitter"
        ];
      };
      byteCompileLua = {
        enable = false;
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
      treesitter = {
        enable = helpers.enableExceptInTests;
      };
      cmp = enabled;
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
      have_nerd_font = true;
      bigfile_size = 1024 * 1024 * 3; # 3mb
    };

    filetype = {
      pattern = {
        ".*" = helpers.mkRaw ''
          function(path, buf)
            return vim.bo[buf]
                and vim.bo[buf].filetype ~= "bigfile"
                and path
                and vim.fn.getfsize(path) > vim.g.bigfile_size
                and "bigfile"
              or nil
          end
        '';
      };
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

    opts = {
      background = "dark";
      backup = false; # creates a backup file
      writebackup = false; # if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
      clipboard = "unnamedplus"; # allows neovim to access the system clipboard
      cmdheight = 1; # more space in the neovim command line for displaying messages
      completeopt = [
        "menuone"
        "noselect"
        "noinsert"
      ];
      conceallevel = 0; # so that `` is visible in markdown files
      fileencoding = "utf-8"; # the encoding written to a file
      hidden = true; # required to keep multiple buffers and open multiple buffers

      hlsearch = true; # highlight all matches on previous search pattern
      incsearch = true;
      ignorecase = true; # ignore case in search patterns

      showmode = false; # we don't need to see things like -- INSERT -- anymore
      smartcase = true; # smart case
      splitbelow = true; # force all horizontal splits to go below current window
      splitright = true; # force all vertical splits to go to the right of current window
      swapfile = false; # creates a swapfile
      termguicolors = true; # set term gui colors (most terminals support this)
      timeoutlen = 350; # time to wait for a mapped sequence to complete (in milliseconds)
      title = true; # set the title of window to the value of the titlestring
      titlestring = "%<%F%=%l/%L - xetavim"; # what the title of the window will be set to
      undofile = true; # enable persistent undo
      updatetime = 50; # faster completion
      expandtab = true; # convert tabs to spaces
      autoindent = true;
      smartindent = true;
      shiftwidth = 2; # the number of spaces inserted for each indentation
      softtabstop = 2;
      tabstop = 2; # insert 2 spaces for a tab
      cursorline = true; # highlight the current line
      relativenumber = true; # make line numbering relative to cursor position
      numberwidth = 2; # set number column width to 2 {default 4}
      signcolumn = "yes"; # always show the sign column, otherwise it would shift the text each time
      wrap = false; # display lines as one long line
      scrolloff = 8; # minimal number of screen lines to keep above and below the cursor.
      sidescrolloff = 8; # minimal number of screen lines to keep left and right of the cursor.
      showcmd = false;
      ruler = false;
      laststatus = 3;
      autowrite = true;
      wildmode = "longest:full,full";
      virtualedit = "block"; # allow cursor to move where there is no text in visual block mode:wildmode
      smoothscroll = true;
      foldmethod = "expr";
      linebreak = true; # Wrap lines at convenient points
      list = true; # Show some invisible characters (tabs...
      mouse = "a"; # Enable mouse mode
      number = true; # Print line number
      pumblend = 10; # Popup blend
      pumheight = 10; # Maximum number of entries in a popup
    };

    plugins = {
      render-markdown = {
        enable = true;
        settings = {
          debounce = 100;
          max_file_size = 20.0;
          injections = {
            gitcommit = {
              enabled = true;
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
      undotree = enabled;
      persistence = {
        enable = true;
      };
      indent-blankline = {
        enable = true;
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

      sleuth = {
        enable = false;
      };

      # TODO: qwjqwid
      # INFO: Highlight todo, notes, etc in comments
      # https://nix-community.github.io/nixvim/plugins/todo-comments/index.html
      todo-comments = {
        enable = true;
        settings = {
          signs = true;
        };
      };

      barbecue = enabled;
      rainbow-delimiters = {
        enable = helpers.enableExceptInTests;
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
      notify = {
        enable = true;
        fps = 60;
        timeout = 3000;
        stages = "static";
        maxHeight = helpers.mkRaw ''
          function()
            return math.floor(vim.o.lines * 0.75)
          end
        '';
        maxWidth = helpers.mkRaw ''
          function()
            return math.floor(vim.o.columns * 0.75)
          end
        '';
        onOpen = helpers.mkRaw ''
          function(win)
            vim.api.nvim_win_set_config(win, { zindex = 100 })
          end
        '';
        backgroundColour = "NotifyBackground";
      };
      lazygit = disabled;
      transparent = {
        enable = true;
      };
    };

    extraPlugins = [
      plugins.nvim-lspconfig
      plugins.nvim-various-textobjs
      plugins.nvim-treesitter-textsubjects
      plugins.satellite-nvim
      # plugins.nvim-web-devicons # TODO: Figure out how to configure using this with telescope
      plugins.vim-wordmotion
      plugins.vim-smartword
      plugins.telescope-file-browser-nvim
    ];
  };
}
