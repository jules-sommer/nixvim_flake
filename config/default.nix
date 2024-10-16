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
      bigfile_size = 1024 * 1024 * 1.5; # 1.5 MB
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
      background = "";
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
      # foldmethod = "manual"; # folding, set to "expr" for treesitter based folding
      foldexpr = ""; # set to "nvim_treesitter#foldexpr()" for treesitter based folding
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
      # undodir = "/.local/share/nvim/undodir"; # set an undo directory
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
      foldtext = "";
      linebreak = true; # Wrap lines at convenient points
      list = true; # Show some invisible characters (tabs...
      mouse = "a"; # Enable mouse mode
      number = true; # Print line number
      pumblend = 10; # Popup blend
      pumheight = 10; # Maximum number of entries in a popup
    };

    plugins = {
      fugitive = enabled;
      git-conflict = {
        enable = true;
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
      neo-tree = disabled;
      undotree = enabled;
      presence-nvim = enabled;
      multicursors = {
        enable = true;
        createCommands = true;
        updatetime = 50;
        nowait = true;
        generateHints = {
          normal = true;
          insert = true;
          extend = true;
        };
        hintConfig = {
          type = "window";
          position = "bottom";
        };
      };
      # plugins.bufferline.'.
      bufferline = {
        enable = false;
        settings.options = {
          color_icons = true;
          close_icons = false;
          max_name_length = 35;
          # separator_style = "";
          left_trunc_marker = "<||";
          themable = true;
          tab_size = 18;
        };
      };
      sniprun = {
        enable = true;
        package = pkgs.vimPlugins.sniprun;
      };
      persistence = {
        enable = true;
        saveEmpty = false;
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
              "help"
              "alpha"
              "dashboard"
              "neo-tree"
              "Trouble"
              "startup"
              "startify"
              "dashboard"
              "trouble"
              "lazy"
              "mason"
              "notify"
              "toggleterm"
              "lazyterm"
              "neo-tree-popup"
              "lspinfo"
              "TelescopePrompt"
              "TelescopeResults"
              "yaml"
            ];
          };

          # highlights for plugin set @ ./colorscheme/default.nix
          indent = {
            char = "│";
            tab_char = "│";
          };
          scope = {
            show_end = false;
            show_exact_scope = false;
            show_start = false;
          };
        };
      };

      sleuth = {
        enable = true;
      };

      # Highlight todo, notes, etc in comments
      # https://nix-community.github.io/nixvim/plugins/todo-comments/index.html
      todo-comments = {
        enable = true;
        settings = {
          signs = true;
        };
      };

      barbar = disabled;
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

      better-escape = enabled;
      neoscroll = disabled;
      harpoon = enabled;
      ccc = disabled;
      floaterm = enabled;
      gitsigns = enabled;
      # lualine = enabled;
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
      lazygit = enabled;
      transparent = {
        enable = true;
      };
      zellij = disabled;
    };

    extraPlugins = [
      plugins.nvim-lspconfig
      plugins.nvim-various-textobjs
      plugins.nvim-treesitter-textsubjects
      # plugins.zoxide-vim
      plugins.satellite-nvim
      plugins.nvim-web-devicons # TODO: Figure out how to configure using this with telescope
      plugins.vim-wordmotion
      plugins.vim-smartword
      # plugins.fzf-vim
      plugins.telescope-file-browser-nvim
    ];
  };
}
