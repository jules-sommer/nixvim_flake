{
  theme,
  ...
}:
{
  config = {
    colorschemes = {
      kanagawa = {
        settings = {
          commentStyle = {
            italic = false;
          };
          compile = true;
          dimInactive = true;
          terminalColors = true;
          theme = "dragon";
          transparent = true;
          undercurl = true;
        };
      };

      tokyonight = {
        settings = {
          style = "night";
          terminal_colors = true;
          transparent = true;
        };
      };

      rose-pine.settings = {
        dark_variant = "moon";
        dim_inactive_windows = true;
        enable = {
          legacy_highlights = false;
          migrations = true;
          terminal = true;
        };
        extend_background_behind_borders = true;
        styles = {
          bold = true;
          italic = false;
          transparency = true;
        };
        variant = "moon";
      };
    };

    plugins.indent-blankline =
      let
        highlight = [
          "RainbowDelimiterRed"
          "RainbowDelimiterYellow"
          "RainbowDelimiterBlue"
          "RainbowDelimiterOrange"
          "RainbowDelimiterGreen"
          "RainbowDelimiterViolet"
          "RainbowDelimiterCyan"
        ];
      in
      {
        settings = {
          indent = {
            inherit highlight;
            priority = 1;
          };
          scope = {
            inherit highlight;
            priority = 1024;
          };
        };
      };

    highlight =
      let
        colors = {
          blue = {
            fg = "#7aa2f7";
          };
          cyan = {
            fg = "#7dcfff";
          };
          green = {
            fg = "#9ece6a";
          };
          orange = {
            fg = "#ff9e64";
          };
          red = {
            fg = "#f7768e";
          };
          violet = {
            fg = "#9d7cd8";
          };
          yellow = {
            fg = "#e0af68";
          };
          transparent = {
            bg = "NONE";
          };
        };
      in
      {
        RainbowBlue = {
          inherit (colors.blue) fg;
          inherit (colors.transparent) bg;
          blend = 25;
        };
        RainbowCyan = {
          inherit (colors.cyan) fg;
          inherit (colors.transparent) bg;
          blend = 25;
        };
        RainbowGreen = {
          inherit (colors.green) fg;
          inherit (colors.transparent) bg;
          blend = 25;
        };
        RainbowOrange = {
          inherit (colors.orange) fg;
          inherit (colors.transparent) bg;
          blend = 25;
        };
        RainbowRed = {
          inherit (colors.red) fg;
          inherit (colors.transparent) bg;
          blend = 25;
        };
        RainbowViolet = {
          inherit (colors.violet) fg;
          inherit (colors.transparent) bg;
          blend = 25;
        };
        RainbowYellow = {
          inherit (colors.yellow) fg;
          inherit (colors.transparent) bg;
          blend = 25;
        };
      };

    highlightOverride =
      with theme;
      with theme.colors;
      with theme.diagnostic;
      let
        FloatBorderDefault = {
          fg = "#c4a7e7";
          bg = null;
          blend = 10;
        };
      in
      {
        # base00:"#232136"
        # base01:"#2a273f"
        # base02:"#393552"
        # base03:"#6e6a86"
        # base04:"#908caa"
        # base05:"#e0def4"
        # base06:"#e0def4"
        # base07:"#56526e"
        # base08:"#eb6f92"
        # base09:"#f6c177"
        # base0A:"#ea9a97"
        # base0B:"#3e8fb0"
        # base0C:"#9ccfd8"
        # base0D:"#c4a7e7"
        # base0E:"#f6c177"
        # base0F:"#56526e"

        NormalFloat = FloatBorderDefault;
        Normal = FloatBorderDefault;
        Pmenu = FloatBorderDefault;
        PmenuSel = FloatBorderDefault;

        FloatBorder = FloatBorderDefault;
        NotifyBackground = FloatBorderDefault;
        FloatFooter = FloatBorderDefault;
        FloatTitle = FloatBorderDefault;

        TelescopeBorder = FloatBorderDefault;
        TelescopeFloatBorder = FloatBorderDefault;
        TelescopeFloat = FloatBorderDefault;
        TelescopePromptBorder = FloatBorderDefault;
        TelescopePromptTitle = FloatBorderDefault;
        Float = FloatBorderDefault;
        LspFloatWinBorder = FloatBorderDefault;
        LspFloatWinNormal = FloatBorderDefault;
        LspInfoBorder = FloatBorderDefault;
        IncSearch = FloatBorderDefault // {
          bold = true;
        };

        Search = FloatBorderDefault // {
          bold = true;
        };

        SignColumn = {
          bg = null;
          fg = "#ca88ff";
          blend = 30;
        };

        "@property" = {
          fg = "#c4a7e7";
        };

        "@lsp" = {
          fg = "#c4a7e7";
        };

        "@variable" = {
          fg = "#c4a7e7";
        };

        Keyword = {
          fg = "#C70074";
        };

        "@keyword" = {
          fg = "#C70074";
        };
        comments = {
          bold = true;
          fg = "#e0def4";
          blend = 30;
        };
        LspInlayHint = {
          fg = "#e864fc";
          bg = null;
          blend = 50;
          bold = true;
        };
        Function = {
          fg = "#00FACC";
          bold = true;
        };
        Type = {
          fg = "#15CEEF";
          # fg = "#FF007C";
        };
        Statement = {
          fg = "#15CEEF";
        };

        LspCodeLens = {
          fg = "#565f89";
        };
        Variable = {
          fg = "#f6c177";
        };

        Identifier = {
          fg = "#f6c177";
        };

        RainbowDelimiterBlue = {
          fg = "#7aa2f7";
          bg = null;
          blend = 80;
        };
        RainbowDelimiterCyan = {
          fg = "#7dcfff";
          bg = null;
          blend = 80;
        };
        RainbowDelimiterGreen = {
          fg = "#9ece6a";
          bg = null;
          blend = 80;
        };
        RainbowDelimiterOrange = {
          fg = "#ff9e64";
          bg = null;
          blend = 80;
        };
        RainbowDelimiterRed = {
          fg = "#f7768e";
          bg = null;
          blend = 80;
        };
        RainbowDelimiterViolet = {
          fg = "#9d7cd8";
          bg = null;
          blend = 80;
        };
        RainbowDelimiterYellow = {
          fg = "#e0af68";
          bg = null;
          blend = 80;
        };

        DiagnosticWarn.link = "DiagnosticVirtualTextWarn";
        DiagnosticInfo.link = "DiagnosticVirtualTextInfo";
        DiagnosticHint.link = "DiagnosticVirtualTextHint";
        DiagnosticOk.link = "DiagnosticVirtualTextOk";
        DiagnosticError.link = "DiagnosticVirtualTextError";

        DiagnosticVirtualTextError = {
          fg = "#FF007B";
          bg = "NONE";
          blend = 30;
        };

        DiagnosticVirtualTextWarn = {
          fg = base0A;
          bg = "NONE";
          blend = 30;
        };

        DiagnosticVirtualTextInfo = {
          fg = base0C;
          bg = "NONE";
          blend = 30;
        };

        DiagnosticVirtualTextHint = {
          fg = base0C;
          bg = "NONE";
          blend = 30;
        };

        DiagnosticVirtualTextOk = {
          fg = base0D;
          bg = "NONE";
          blend = 30;
        };

        DiagnosticUnnecessary =
          {
          };
      };
  };
}
