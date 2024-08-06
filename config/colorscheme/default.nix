{
  lib,
  config,
  pkgs,
  theme,
  ...
}:
let
  cfg = config.colorschemes;
in
{
  config = {
    assertions = [
      {
        # ensure that only one colorscheme is enabled
        assertion = cfg.tokyonight.enable || cfg.kanagawa.enable;
        message = "Only one colorscheme can be enabled at a time.";
      }
    ];
    colorschemes.kanagawa = {
      settings = {
        colors = {
          theme = {
            all = {
              ui = {
                float = {
                  bg_gutter = "none";
                  bg = "none";
                };
                pmenu = {
                  bg = "none";
                  fg = theme.colors.base03;
                };
                bg_search = "none";
                bg_visual = "none";

                bg_gutter = "none";
              };
            };
          };
        };
        overrides = ''
          function(colors)
            local theme = colors.theme
            return {
              NormalFloat = { bg = "none" },
              FloatBorder = { bg = "none" },
              FloatTitle = { bg = "none" },

              -- Save an hlgroup with dark background and dimmed foreground
              -- so that you can use it where your still want darker windows.
              -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
              NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

              -- Popular plugins that open floats will link to NormalFloat by default;
              -- set their background accordingly if you wish to keep them dark and borderless
              -- LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
              -- MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

              -- TelescopeTitle = { fg = theme.ui.special, bold = true },
              -- TelescopePromptNormal = { bg = theme.ui.bg_p1 },
              -- TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = "none" },
              -- TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = "none" },
              -- TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = "none" },
              -- TelescopePreviewNormal = { bg = theme.ui.bg_dim },
              -- TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },

              -- Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1, blend = vim.o.pumblend },  -- add `blend = vim.o.pumblend` to enable transparency
              -- PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
              -- PmenuSbar = { bg = theme.ui.bg_m1 },
              -- PmenuThumb = { bg = theme.ui.bg_p2 },
            }
          end
        '';
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

    # settings for tokyo-night-dark nvim theme (which our base24 theme is based on).
    colorschemes.tokyonight = {
      settings = {
        style = "night";
        terminal_colors = true;
        transparent = true;
      };
    };

    # highlight groups for indent lines/guides
    # uses this flake's custom "RainbowColor" highlight groups ( set below )
    plugins.indent-blankline =
      let
        highlight = [
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
        settings = {
          indent = {
            inherit highlight;
          };
          scope = {
            inherit highlight;
          };
        };
      };

    # highlight setting is for nvim highlight groups that are
    # custom, i.e not overriding an existing highlight group.
    highlight = with theme.colors; {
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
    };

    # this override setting is for overriding highlight groups
    # that have been set by neovim or another plugin by default
    highlightOverride =
      with theme.colors;
      with theme.diagnostic;
      {
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

        Normal = {
          fg = base05;
          bg = "NONE";
        };
        LineNr = {
          fg = base05;
          bg = "NONE";
        };
        SignColumn = {
          fg = base05;
          bg = "NONE";
        };

        Comment = {
          fg = base05;
          bg = "NONE";
          bold = true;
          italic = true;
        };

        CmpCompletionBorder = {
          fg = base06;
          bg = "NONE";
        };

        FloatBorder = {
          fg = base06;
          bg = "NONE";
        };

        NormalFloat = {
          fg = base06;
          bg = "NONE";
          blend = 95;
        };

        TabLine = {
          fg = base06;
          bg = "NONE";
        };

        FloatermBorder = {
          fg = base06;
          bg = "NONE";
        };

        MsgArea = {
          fg = base06;
          bg = "NONE";
        };

        Pmenu = {
          bg = "NONE";
          fg = base01;
        };

        PmenuSel = {
          bg = "NONE";
          fg = base01;
        };

        TelescopeNormal = {
          bg = "NONE";
          fg = base01;
        };

        TelescopePromptNormal = {
          bg = "NONE";
          fg = base06;
        };

        TelescopePromptPrefix = {
          fg = base0D;
          bg = "NONE";
          bold = true;
        };

        TelescopePromptCounter = {
          fg = base0E;
          bg = "NONE";
          bold = true;
        };

        TelescopePromptTitle = {
          fg = base0B;
          bg = "NONE";
          bold = true;
        };

        TelescopePromptBorder = {
          bg = "NONE";
          fg = base06;
        };

        TelescopeResultsNormal = {
          bg = "NONE";
          fg = base06;
        };

        TelescopeResultsTitle = {
          fg = base0C;
          bg = "NONE";
          bold = true;
        };

        TelescopeResultsBorder = {
          bg = "NONE";
          fg = base06;
        };

        TelescopePreviewNormal = {
          bg = "NONE";
          fg = base06;
        };

        TelescopePreviewTitle = {
          fg = base0B;
          bg = "NONE";
          bold = true;
        };

        LspInlayHint = {
          fg = base0C;
          bg = "NONE";
          bold = true;
          blend = 95;
        };

        VirtText = {
          bg = "NONE";
          fg = base0C;
          bold = true;
        };

        LspReferenceText = {
          fg = base03;
          bg = "NONE";
        };

        TelescopePreviewBorder = {
          bg = "NONE";
          fg = base06;
        };

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
  };
}
