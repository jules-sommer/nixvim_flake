{ lib, pkgs, ... }: 
let
  inherit (lib) enabled disabled;
  plugins = pkgs.vimPlugins;
in
{
  imports = [

  ];

  config = {
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
        # highlights = {
        #   fill = {
        #     fg = colors.base06;
        #     bg = colors.base01;
        #     blend = 20;
        #   };
        #   closeButton = {
        #     fg = colors.base05;
        #     bg = colors.base00;
        #     blend = 20;
        #   };
        #   separator = {
        #     fg = colors.base03;
        #     bg = colors.base00;
        #     blend = 20;
        #   };
        #   trunkMarker = {
        #     fg = colors.base0A;
        #     bg = colors.base00;
        #     blend = 20;
        #   };
        #   background = {
        #     fg = colors.base0F;
        #     bg = colors.base00;
        #   };
        #   tab = {
        #     fg = colors.base05;
        #     bg = colors.base02;
        #   };
        #   tabSelected = {
        #     fg = colors.base06;
        #     bg = colors.base0B;
        #   };
        #   tabSeparator = {
        #     fg = null;
        #     bg = colors.base00;
        #   };
        #   tabSeparatorSelected = {
        #     fg = null;
        #     bg = colors.base0B;
        #     sp = null;
        #     underline = null;
        #   };
        # };
      };
      sniprun = {
        enable = true;
      };
      persistence = {
        enable = true;
        saveEmpty = false;
      };
      indent-blankline =
        let
          highlights = [
            "RainbowRed"
            "RainbowYellow"
            "RainbowBlue"
            "RainbowOrange"
            "RainbowGreen"
            "RainbowViolet"
            "RainbowCyan"
          ];
        in
        {
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

            indent = {
              char = "│";
              highlight = highlights;
            };
            scope = {
              show_end = false;
              show_exact_scope = true;
              show_start = true;
              highlight = highlights;
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
