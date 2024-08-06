{
  config,
  lib,
  pkgs,
  helpers,
  plugins,
  ...
}:
let
  inherit (lib)
    enabled
    disabled
    mkOpt
    types
    ;
in
{
  imports = [
    ./colorscheme/default.nix
    ./yanky/default.nix
    ./supermaven/default.nix
    ./lsp/default.nix
    ./hop/default.nix
    ./ollama/default.nix
    ./cmp/default.nix
    ./telescope/default.nix
    ./treesitter/default.nix
    ./startup/default.nix
    ./oil/default.nix
  ];

  config = {
    # settings for this flake's implementation of nixvim
    lsp = enabled;
    plugins = {
      oil = enabled;
      startup = enabled;
      telescope = enabled;
      yanky = enabled;
      ollama = enabled;
      noice = enabled;
      hop = enabled;
      supermaven = {
        enable = helpers.enableExceptInTests;
        settings = {
          inline-completion = {
            enable = true;
            suggestion-color = "#c899cc";
          };
          keymaps = {
            enable = true;
            accept-suggestion = "<Tab>";
            clear-suggestion = "<C-c>";
            accept-word = "<C-j>";
            toggle-inline-completion = "<leader>s";
          };
        };
      };
      treesitter = {
        enable = helpers.enableExceptInTests;
      };
      cmp = enabled;
    };

    colorschemes.kanagawa = disabled;
    colorschemes.tokyonight = enabled;

    extraConfigLua = ''
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "kanagawa",
        callback = function()
          if vim.o.background == "light" then
            vim.fn.system("kitty +kitten themes Kanagawa_light")
          elseif vim.o.background == "dark" then
            vim.fn.system("kitty +kitten themes Kanagawa_dragon")
          else
            vim.fn.system("kitty +kitten themes Kanagawa")
          end
        end,
      })
    '';

    globals.mapleader = " ";
    filetype.extension.nu = "nu";

    opts = {

      background = "";
      backup = false; # creates a backup file
      writebackup = false; # if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
      clipboard = "unnamedplus"; # allows neovim to access the system clipboard
      cmdheight = 1; # more space in the neovim command line for displaying messages
      completeopt = [
        "menuone"
        "noselect"
      ];
      conceallevel = 0; # so that `` is visible in markdown files
      fileencoding = "utf-8"; # the encoding written to a file
      foldmethod = "manual"; # folding, set to "expr" for treesitter based folding
      foldexpr = ""; # set to "nvim_treesitter#foldexpr()" for treesitter based folding
      hidden = true; # required to keep multiple buffers and open multiple buffers

      hlsearch = true; # highlight all matches on previous search pattern
      incsearch = true;
      ignorecase = true; # ignore case in search patterns

      mouse = "a"; # allow the mouse to be used in neovim
      pumheight = 10; # pop up menu height
      showmode = false; # we don't need to see things like -- INSERT -- anymore
      smartcase = true; # smart case
      splitbelow = true; # force all horizontal splits to go below current window
      splitright = true; # force all vertical splits to go to the right of current window
      swapfile = false; # creates a swapfile
      termguicolors = true; # set term gui colors (most terminals support this)
      timeoutlen = 300; # time to wait for a mapped sequence to complete (in milliseconds)
      title = true; # set the title of window to the value of the titlestring
      titlestring = "%<%F%=%l/%L - xetavim"; # what the title of the window will be set to
      undodir = "undodir"; # set an undo directory
      undofile = true; # enable persistent undo
      updatetime = 50; # faster completion
      expandtab = true; # convert tabs to spaces
      autoindent = true;
      smartindent = true;
      shiftwidth = 2; # the number of spaces inserted for each indentation
      softtabstop = 2;
      tabstop = 2; # insert 2 spaces for a tab
      cursorline = true; # highlight the current line
      number = true; # set numbered lines
      relativenumber = true; # make line numbering relative to cursor position
      numberwidth = 4; # set number column width to 2 {default 4}
      signcolumn = "yes"; # always show the sign column, otherwise it would shift the text each time
      wrap = false; # display lines as one long line
      scrolloff = 8; # minimal number of screen lines to keep above and below the cursor.
      sidescrolloff = 8; # minimal number of screen lines to keep left and right of the cursor.
      showcmd = false;
      ruler = false;
      laststatus = 3;
    };

    plugins = {
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
      bufferline = {
        enable = true;
        colorIcons = true;
        closeIcon = " ";
        leftTruncMarker = "<||";
        maxNameLength = 30;
        separatorStyle = "slant";
        themable = true;
        tabSize = 18;
      };
      sniprun = {
        enable = true;
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
              ""
              "checkhealth"
              "NvimTree"
              "help"
              "lspinfo"
              "TelescopePrompt"
              "TelescopeResults"
              "yaml"
            ];
          };

          # highlights for plugin set in `config/highlights/default.nix`
          indent = {
            char = "│";
          };
          scope = {
            show_end = false;
            show_exact_scope = true;
            show_start = true;
          };
        };
      };

      barbar = enabled;

      barbecue = enabled;
      rainbow-delimiters.enable = helpers.enableExceptInTests;
      better-escape = enabled;
      neoscroll = enabled;
      # harpoon = enabled;
      ccc = enabled;
      gitsigns = enabled;
      lualine = enabled;
      notify = enabled;
      lazygit = enabled;
      transparent = {
        enable = true;
        settings = {
          extra_groups = [
            "BufferLineTabClose"
            "BufferLineBufferSelected"
            "BufferLineFill"
            "BufferLineBackground"
            "BufferLineSeparator"
            "BufferLineIndicatorSelected"
            "TelescopePrompt"
            "TelescopeNormal"
            "TelescopePromptNormal"
            "TelescopePromptBorder"
            "TelescopeResultsBorder"
            "TelescopePreviewBorder"
            "TelescopePromptTitle"
            "TelescopeResultsTitle"
            "TelescopePreviewTitle"
            "TelescopePreviewNormal"
            "Pmenu"
            "SignColumn"
            "PmenuSel"
            "NormalFloat"
            "NormalDark"
          ];
        };
      };
      zellij = enabled;
    };

    extraPlugins = [
      {
        plugin = plugins.nvim-nu;
        config = "lua require('nu').setup()";
      }
      plugins.zoxide-vim
      plugins.vim-wordmotion
      plugins.vim-smartword
      plugins.supermaven-nvim
      plugins.vim-vsnip
      plugins.fzf-vim
      plugins.telescope-file-browser-nvim
    ];
  };
}
