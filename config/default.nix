{
  lib,
  helpers,
  config,
  theme,
  plugins,
  ...
}:
with lib;
{
  imports = [
    # ./colorscheme/default.nix
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
    ./undotree/default.nix
    # ./neo-tree/default.nix
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

    colorschemes.kanagawa = {
      enable = false;
      settings = {
        colors = {
          theme = {
            all = {
              ui = {
                float = {
                  bg_gutter = theme.colors.base00;
                  bg = theme.colors.base00;
                };
                pmenu = {
                  bg = theme.colors.base00;
                  fg = theme.colors.base03;
                };
                bg_search = "none";
                bg_visual = "none";

                bg_gutter = "none";
              };
            };
          };
        };
        # overrides = ''
        #   function(colors)
        #     local theme = colors.theme
        #     return {
        #       NormalFloat = { bg = theme.ui.bg_m3 },
        #       FloatBorder = { bg = "none" },
        #       FloatTitle = { bg = "none" },
        #
        #       -- Save an hlgroup with dark background and dimmed foreground
        #       -- so that you can use it where your still want darker windows.
        #       -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
        #       NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
        #
        #       -- Popular plugins that open floats will link to NormalFloat by default;
        #       -- set their background accordingly if you wish to keep them dark and borderless
        #       LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        #       -- MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        #
        #       -- TelescopeTitle = { fg = theme.ui.special, bold = true },
        #       -- TelescopePromptNormal = { bg = theme.ui.bg_p1 },
        #       TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = "none" },
        #       -- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = "none" },
        #       -- TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = "none" },
        #       -- TelescopePreviewNormal = { bg = theme.ui.bg_dim },
        #       -- TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
        #
        #       Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend },  -- add `blend = vim.o.pumblend` to enable transparency
        #       PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
        #       PmenuSbar = { bg = theme.ui.bg_m1 },
        #       PmenuThumb = { bg = theme.ui.bg_p2 },
        #     }
        #   end
        # '';
        commentStyle = {
          italic = true;
        };
        compile = false;
        dimInactive = false;
        functionStyle = { };
        terminalColors = true;
        theme = "dragon";
        transparent = true;
        undercurl = true;
      };
    };
    colorschemes.tokyonight = enabled;
    colorschemes.rose-pine = {
      enable = false;
      settings = {
        # before_highlight = "function(group, highlight, palette) end";
        dark_variant = "moon";
        dim_inactive_windows = true;
        enable = {
          legacy_highlights = false;
          migrations = true;
          terminal = true;
        };
        extend_background_behind_borders = true;
        groups = {
          border = "muted";
          link = "iris";
          panel = "surface";

          error = "love";
          hint = "iris";
          info = "foam";
          note = "pine";
          todo = "rose";
          warn = "gold";

          git_add = "foam";
          git_change = "rose";
          git_delete = "love";
          git_dirty = "rose";
          git_ignore = "muted";
          git_merge = "iris";
          git_rename = "pine";
          git_stage = "iris";
          git_text = "rose";
          git_untracked = "subtle";

          h1 = "iris";
          h2 = "foam";
          h3 = "rose";
          h4 = "gold";
          h5 = "pine";
          h6 = "foam";
        };

        highlight_groups = {
          Pmenu = {
            bg = "NONE";
            fg = "text";
          };

          PmenuSel = {
            bg = "NONE";
            fg = "text";
          };

          TelescopePromptNormal = {
            bg = "muted";
            fg = "text";
          };

          TelescopePromptPrefix = {
            fg = "text";
            bg = "NONE";
            bold = true;
          };

          TelescopePromptCounter = {
            fg = "text";
            bg = "NONE";
            bold = true;
          };

          TelescopePromptTitle = {
            fg = "text";
            bg = "NONE";
            bold = true;
          };

          TelescopePromptBorder = {
            bg = "NONE";
            fg = "muted";
          };

          TelescopeResultsNormal = {
            bg = "NONE";
            fg = "text";
          };

          TelescopeResultsTitle = {
            fg = "text";
            bg = "NONE";
            bold = true;
          };

          TelescopeResultsBorder = {
            bg = "NONE";
            fg = "muted";
          };

          TelescopePreviewNormal = {
            bg = "NONE";
            fg = "text";
          };

          TelescopePreviewTitle = {
            fg = "text";
            bg = "NONE";
            bold = true;
          };
          NormalFloat = {
            bg = "surface";
            fg = "text";
          };
          TelescopeBorder = {
            bg = "none";
            fg = "text";
          };
          TelescopeFloat = {
            bg = "surface";
            fg = "text";
          };
          FloatBorder = {
            bg = "none";
            fg = "text";
          };
          FloatTitle = {
            bg = "surface";
            fg = "text";
          };
        };
        styles = {
          bold = true;
          italic = true;
          transparency = true;
        };
        variant = "moon";
      };
    };
    highlightOverride =
      with theme.colors;
      with theme.diagnostic;
      {
        RainbowRed = {
          fg = base0F;
          bg = "NONE";
          bold = true;
          blend = 95;
        };

        RainbowYellow = {
          fg = base0A;
          bg = "NONE";
          bold = true;
          blend = 95;
        };

        RainbowBlue = {
          fg = base0D;
          bg = "NONE";
          bold = true;
          blend = 95;
        };

        RainbowOrange = {
          fg = base09;
          bg = "NONE";
          bold = true;
          blend = 95;
        };

        RainbowGreen = {
          fg = base0B;
          bg = "NONE";
          bold = true;
          blend = 95;
        };

        RainbowViolet = {
          fg = base0E;
          bg = "NONE";
          bold = true;
          blend = 95;
        };

        RainbowCyan = {
          fg = base0C;
          bg = "NONE";
          bold = true;
          blend = 95;
        };

        # Search + IncSearch for plugins.yanky
        IncSearch = {
          fg = base06;
          bg = base13;
          bold = true;
        };

        Search = {
          fg = base02;
          bg = base0E;
          bold = true;
        };
        # end plugins.yanky

        # Normal = {
        #   fg = base05;
        #   bg = "NONE";
        # };
        # LineNr = {
        #   fg = base05;
        #   bg = "NONE";
        # };
        # SignColumn = {
        #   fg = base05;
        #   bg = "NONE";
        # };
        #
        # Comment = {
        #   fg = base05;
        #   bg = "NONE";
        #   bold = true;
        #   italic = true;
        # };
        #
        # CmpCompletionBorder = {
        #   fg = base06;
        #   bg = "NONE";
        # };

        FloatBorder = {
          fg = base06;
          bg = "NONE";
        };

        # NormalFloat = {
        #   fg = base06;
        #   bg = "NONE";
        #   blend = 20;
        # };

        # TabLine = {
        #   fg = base06;
        #   bg = "NONE";
        # };
        #
        # FloatermBorder = {
        #   fg = base06;
        #   bg = "NONE";
        # };
        #
        # MsgArea = {
        #   fg = base06;
        #   bg = "NONE";
        # };

        Pmenu = {
          bg = "NONE";
          fg = base01;
        };

        PmenuSel = {
          bg = "NONE";
          fg = base01;
        };

        #
        # TelescopePromptNormal = {
        #   bg = base00;
        #   fg = base06;
        # };
        #
        # TelescopePromptPrefix = {
        #   fg = base0D;
        #   bg = "NONE";
        #   bold = true;
        # };
        #
        # TelescopePromptCounter = {
        #   fg = base0E;
        #   bg = "NONE";
        #   bold = true;
        # };
        #
        # TelescopePromptTitle = {
        #   fg = base0B;
        #   bg = "NONE";
        #   bold = true;
        # };
        #
        # TelescopePromptBorder = {
        #   bg = "NONE";
        #   fg = base06;
        # };
        #
        # TelescopeResultsNormal = {
        #   bg = "NONE";
        #   fg = base06;
        # };
        #
        # TelescopeResultsTitle = {
        #   fg = base0C;
        #   bg = "NONE";
        #   bold = true;
        # };
        #
        # TelescopeResultsBorder = {
        #   bg = "NONE";
        #   fg = base06;
        # };
        #
        # TelescopePreviewNormal = {
        #   bg = "NONE";
        #   fg = base06;
        # };
        #
        # TelescopePreviewTitle = {
        #   fg = base0B;
        #   bg = "NONE";
        #   bold = true;
        # };

        LspInlayHint = {
          fg = base0C;
          bg = "NONE";
          bold = true;
          blend = 95;
        };

        VirtText = {
          bg = "NONE";
          fg = base03;
          bold = true;
        };

        LspReferenceText = {
          fg = base03;
          bg = "NONE";
        };

        # TelescopeNormal = {
        #   bg = base00;
        #   fg = base04;
        # };

        TelescopePreviewBorder = {
          bg = "NONE";
          fg = base06;
        };

        # TelescopeResults = {
        #   bg = "NONE";
        #   fg = base06;
        # };

        TelescopeBorder = {
          bg = "NONE";
          fg = base06;
        };

        DiagnosticWarn.link = "DiagnosticVirtualTextWarn";
        DiagnosticInfo.link = "DiagnosticVirtualTextInfo";
        DiagnosticHint.link = "DiagnosticVirtualTextHint";
        DiagnosticOk.link = "DiagnosticVirtualTextOk";
        DiagnosticError.link = "DiagnosticVirtualTextError";

        DiagnosticVirtualTextError = {
          fg = base0F;
          bg = "NONE";
        };

        DiagnosticVirtualTextWarn = {
          fg = base0A;
          bg = "NONE";
        };

        DiagnosticVirtualTextInfo = {
          fg = base0C;
          bg = "NONE";
        };

        DiagnosticVirtualTextHint = {
          fg = base0C;
          bg = "NONE";
        };

        DiagnosticVirtualTextOk = {
          fg = base0D;
          bg = "NONE";
        };

        DiagnosticUnnecessary = {
          fg = virtual.warn.fg;
          bg = "NONE";
        };

        RainbowDelimiterRed.fg = base08;
        RainbowDelimiterRed.bg = "NONE";
        RainbowDelimiterYellow.fg = base0A;
        RainbowDelimiterYellow.bg = "NONE";
        RainbowDelimiterBlue.fg = base0D;
        RainbowDelimiterBlue.bg = "NONE";
        RainbowDelimiterOrange.fg = base09;
        RainbowDelimiterOrange.bg = "NONE";
        RainbowDelimiterGreen.fg = base0B;
        RainbowDelimiterGreen.bg = "NONE";
        RainbowDelimiterViolet.fg = base0E;
        RainbowDelimiterViolet.bg = "NONE";
        RainbowDelimiterCyan.fg = base0C;
        RainbowDelimiterCyan.bg = "NONE";
      };

    # extraConfigLuaPost = ''
    #   vim.api.nvim_create_autocmd("ColorScheme", {
    #     pattern = "kanagawa",
    #     callback = function()
    #       if vim.o.background == "light" then
    #         vim.fn.system("kitty +kitten themes Kanagawa_light")
    #       elseif vim.o.background == "dark" then
    #         vim.fn.system("kitty +kitten themes Kanagawa_dragon")
    #       else
    #         vim.fn.system("kitty +kitten themes Kanagawa")
    #       end
    #     end,
    #   })
    # '';

    globals.mapleader = " ";
    filetype = {
      extension.nu = "nu";
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
      undodir = "~/.local/share/nvim/undodir"; # set an undo directory
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
      numberwidth = 2; # set number column width to 2 {default 4}
      signcolumn = "yes"; # always show the sign column, otherwise it would shift the text each time
      wrap = false; # display lines as one long line
      scrolloff = 8; # minimal number of screen lines to keep above and below the cursor.
      sidescrolloff = 8; # minimal number of screen lines to keep left and right of the cursor.
      showcmd = false;
      ruler = false;
      laststatus = 3;
    };

    plugins = {
      neo-tree = enabled;
      undotree = enabled;
      presence-nvim = enabled;
      arrow = {
        enable = true;
        settings = {
          always_show_path = false;
          custom_actions = {
            open = "function(target_file_name, current_file_name) end";
            split_horizontal = "function(target_file_name, current_file_name) end";
            split_vertical = "function(target_file_name, current_file_name) end";
          };
          full_path_list = [ "update_stuff" ];
          global_bookmarks = false;
          hide_handbook = false;
          index_keys = "123456789zxcbnmZXVBNM,afghjklAFGHJKLwrtyuiopWRTYUIOP";
          leader_key = "<leader>;";
          mappings = {
            clear_all_items = "C";
            delete_mode = "d";
            edit = "e";
            next_item = "]";
            open_horizontal = "-";
            open_vertical = "v";
            prev_item = "[";
            quit = "q";
            remove = "x";
            toggle = "s";
          };
          per_buffer_config = {
            lines = 4;
            satellite = {
              enable = false;
              overlap = true;
              priority = 1000;
            };
            sort_automatically = true;
            zindex = 10;
          };
          save_key = "cwd";
          save_path = ''
            function()
                return vim.fn.stdpath("cache") .. "/arrow"
            end
          '';
          separate_by_branch = false;
          separate_save_and_remove = false;
          show_icons = true;
          window = {
            border = "rounded";
            col = "auto";
            height = "auto";
            relative = "editor";
            row = "auto";
            style = "minimal";
            width = "auto";
          };
        };
      };
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
      # bufferline = {
      #   enable = false;
      #   colorIcons = true;
      #   closeIcon = " ";
      #   leftTruncMarker = "<||";
      #   maxNameLength = 30;
      #   separatorStyle = "slant";
      #   themable = true;
      #   tabSize = 18;
      # };
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
              "neo-tree"
              "neo-tree-popup"
              "mini"
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

      mini = {
        enable = true;
        modules = {
          ai = {
            n_lines = 50;
            search_method = "cover_or_next";
          };
          surround = { };
          base16 = {
            palette = with theme.colors; {
              inherit
                base00
                base01
                base02
                base03
                base04
                base05
                base06
                base07
                base08
                base09
                base0A
                base0B
                base0C
                base0D
                base0E
                base0F
                ;
            };
          };
          basics = { };
          bracketed = { };
          clue = { };
          colors = { };
          comment = { };
          diff = { };
          doc = { };
          extra = { };
          files = { };
          fuzzy = { };
          cursorword = { };
          align = { };
          animate =
            {
              cursor = {
                timing = helpers.mkRaw ''
                  require("mini.animate").gen_timing.cubic({ easing = "in-out", duration = 33, unit = 'total' })
                '';
                # path = helpers.mkRaw ''
                #   require("mini.animate").gen_path.line({
                #     predicate = function() return true end,
                #   })
                # '';
              };
              scroll = {
                timing = helpers.mkRaw ''
                  require("mini.animate").gen_timing.cubic({
                    easing = "in-out",
                    duration = 33,
                    unit = "total"
                  })
                '';
                # subscroll = helpers.mkRaw ''
                #   require("mini.animate").gen_subscroll.equal({
                #     max_output_steps = 30,
                #     predicate = function()
                #       return true 
                #     end
                #   })
                # '';
              };
            }
            // (mkIf (config.plugins.cmp.enable == false) {

              completion = {
                window = {
                  info = {
                    height = 25;
                    width = 80;
                    border = "rounded";
                    zindex = 300;
                    style = "minimal";
                  };
                  signature = {
                    height = 25;
                    width = 80;
                    border = "rounded";
                    zindex = 300;
                    style = "minimal";
                  };
                };
                set_vim_settings = true;
              };
            });
          indentscope = { };
          git = { };
          bufremove = { }; # Remove buffer from buffer list 	README 	Help file
          hipatterns = { }; # Highlight patterns in text 	README 	Help file
          hues = with theme.colors; {
            background = base00;
            foreground = base05;
            n_hues = 8;
            saturation = "medium";
            accent = "bg";
          }; # Generate configurable color scheme 	README 	Help file
          icons = { }; # Icon provider 	README 	Help file
          indentscope = {
            # Draw options
            draw = {
              delay = 75;
              priority = 2;
            };
            mappings = {
              object_scope = "ii";
              object_scope_with_border = "ai";

              goto_top = "[i";
              goto_bottom = "]i";
            };

            options = {
              border = "both";
              indent_at_cursor = true;

              try_as_border = false;
            };

            # Which character to use for drawing scope indicator
            symbol = "│";
          }; # Visualize and work with indent scope 	README 	Help file
          # jump = { }; # Jump to next/previous single character 	README 	Help file
          # jump2d = { }; # 2d 	Jump within visible lines 	README 	Help file
          map = { }; # Window with buffer text overview 	README 	Help file
          misc = { }; # Miscellaneous functions 	README 	Help file
          move = { }; # Move any selection in any direction 	README 	Help file
          notify = { }; # Show notifications 	README 	Help file
          operators = { }; # Text edit operators 	README 	Help file
          pairs = { }; # Autopairs 	README 	Help file
          pick = { }; # Pick anything 	README 	Help file
          sessions = { }; # Session management 	README 	Help file
          splitjoin = { }; # Split and join arguments 	README 	Help file
          starter = { }; # Start screen 	README 	Help file
          statusline = { }; # Statusline 	README 	Help file
          surround = { }; # Surround actions 	README 	Help file
          tabline = { }; # Tabline 	README 	Help file
          test = { }; # Test Neovim plugins 	README 	Help file
          trailspace = { }; # Trailspace (highlight and remove) 	README 	Help file
          visits = { };
        };
      };
      barbar = enabled;
      barbecue = enabled;
      rainbow-delimiters.enable = helpers.enableExceptInTests;
      better-escape = enabled;
      neoscroll = disabled;
      # harpoon = enabled;
      ccc = enabled;
      gitsigns = enabled;
      # lualine = enabled;
      notify = {
        fps = 60;
        timeout = 1000;
        maxWidth = 120;
        minimumWidth = 40;
        backgroundColour = "NotifyBackground";
      };
      lazygit = enabled;
      transparent = {
        enable = true;
      };
      zellij = enabled;
    };

    extraConfigLua = ''
      require('satellite').setup {
        current_only = false,
        winblend = 50,
        zindex = 40,
        excluded_filetypes = {},
        width = 2,
        handlers = {
          cursor = {
            enable = true,
            -- Supports any number of symbols
            symbols = { '⎺', '⎻', '⎼', '⎽' }
            -- symbols = { '⎻', '⎼' }
            -- Highlights:
            -- - SatelliteCursor (default links to NonText
          },
          search = {
            enable = true,
            -- Highlights:
            -- - SatelliteSearch (default links to Search)
            -- - SatelliteSearchCurrent (default links to SearchCurrent)
          },
          diagnostic = {
            enable = true,
            signs = {'-', '=', '≡'},
            min_severity = vim.diagnostic.severity.HINT,
            -- Highlights:
            -- - SatelliteDiagnosticError (default links to DiagnosticError)
            -- - SatelliteDiagnosticWarn (default links to DiagnosticWarn)
            -- - SatelliteDiagnosticInfo (default links to DiagnosticInfo)
            -- - SatelliteDiagnosticHint (default links to DiagnosticHint)
          },
          gitsigns = {
            enable = true,
            signs = { -- can only be a single character (multibyte is okay)
              add = "│",
              change = "│",
              delete = "-",
            },
            -- Highlights:
            -- SatelliteGitSignsAdd (default links to GitSignsAdd)
            -- SatelliteGitSignsChange (default links to GitSignsChange)
            -- SatelliteGitSignsDelete (default links to GitSignsDelete)
          },
          marks = {
            enable = true,
            show_builtins = false, -- shows the builtin marks like [ ] < >
            key = 'm'
            -- Highlights:
            -- SatelliteMark (default links to Normal)
          },
          quickfix = {
            signs = { '-', '=', '≡' },
            -- Highlights:
            -- SatelliteQuickfix (default links to WarningMsg)
          }
        },
      }
    '';
    keymaps = [
      {
        key = "<leader>w";
        action = "<cmd>w<CR>";
        options.desc = "Save";
      }
      {
        key = "<leader>q";
        action = "<cmd>wq<CR>";
        options.desc = "Quit";
      }
      {
        key = "<leader>qa";
        action = "<cmd>wqa<CR>";
        options.desc = "Quit all and save.";
      }
      {
        key = "<leader>cs";
        action = "<cmd>let @/=''<CR>";
        options.desc = "Clear search";
      }
      {
        key = "<leader>bd";
        action = "<cmd>bd<CR>";
        options.desc = "Close buffer";
      }
      {
        key = "<leader>bD";
        action = "<cmd>bd!<CR>";
        options.desc = "Close buffer forcefully.";
      }
    ];

    extraPlugins = [
      {
        plugin = plugins.nvim-nu;
        config = "lua require('nu').setup()";
      }
      plugins.zoxide-vim
      plugins.satellite-nvim
      plugins.vim-wordmotion
      plugins.vim-smartword
      plugins.supermaven-nvim
      plugins.fzf-vim
      plugins.telescope-file-browser-nvim
    ];
  };
}
