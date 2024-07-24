{ lib, pkgs, theme, ... }: {
  config = {
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

    # highlight groups for bufferline tab bar 
    # (menu/tab bar containing open buffers)
    plugins.bufferline.highlights = {
      fill = {
        fg = theme.colors.base06;
        bg = theme.colors.base01;
        blend = 20;
      };
      closeButton = {
        fg = theme.colors.base05;
        bg = theme.colors.base00;
        blend = 20;
      };
      separator = {
        fg = theme.colors.base03;
        bg = theme.colors.base00;
        blend = 20;
      };
      trunkMarker = {
        fg = theme.colors.base0A;
        bg = theme.colors.base00;
        blend = 20;
      };
      background = {
        fg = theme.colors.base0F;
        bg = theme.colors.base00;
      };
      tab = {
        fg = theme.colors.base05;
        bg = theme.colors.base02;
      };
      tabSelected = {
        fg = theme.colors.base06;
        bg = theme.colors.base0B;
      };
      tabSeparator = {
        fg = null;
        bg = theme.colors.base00;
      };
      tabSeparatorSelected = {
        fg = null;
        bg = theme.colors.base0B;
        sp = null;
        underline = null;
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
