{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) enabled mkOpt types;
  plugins = pkgs.vimPlugins;
in
{
  imports = [
    ./colorscheme/default.nix
    ./yanky/default.nix
    ./lsp/default.nix
    ./hop/default.nix
    ./ollama/default.nix
    ./cmp/default.nix
    ./telescope/default.nix
    ./treesitter/default.nix
    ./startup/default.nix
    ./oil/default.nix
  ];

  options.neovim = {
    mapleader = mkOpt (types.str) " " "Default leader key to use.";
  };

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
      cmp = enabled;
    };

    globals.mapleader = " ";
    filetype.extension.nu = "nu";

    opts = {
      clipboard = "unnamedplus";
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      softtabstop = 2;
      tabstop = 2;
      autoindent = true;
      smartindent = true;
      expandtab = true;
      wrap = false;
      swapfile = false;
      backup = false;
      hlsearch = false;
      incsearch = true;
      termguicolors = true;
      scrolloff = 8;
      updatetime = 50;
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
          border = "rounded";
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

      barbecue = enabled;
      rainbow-delimiters = enabled;
      better-escape = enabled;
      neoscroll = enabled;
      # harpoon = enabled;
      ccc = enabled;
      gitsigns = enabled;
      lualine = enabled;
      notify = enabled;
      lazy = {
        enable = true;
      };
      lazygit = enabled;
      transparent = enabled;
      zellij = enabled;
    };

    extraPlugins = [
      {
        plugin = plugins.nvim-nu;
        config = "lua require('nu').setup()";
      }
      plugins.zoxide-vim
      # supermaven-nvim
      plugins.vim-vsnip
      plugins.fzf-vim
      plugins.telescope-file-browser-nvim
    ];
  };
}
