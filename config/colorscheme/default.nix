{
  theme,
  ...
}:
{
  config = {
    highlightOverride =
      with theme;
      with theme.colors;
      with theme.diagnostic;
      let
        FloatBorderDefault = {
          fg = "#c4a7e7";
          # bg = null;
          blend = 10;
        };
      in
      {

        LspInlayHint = {
          fg = "#e864fc";
          bg = null;
          blend = 50;
          bold = true;
        };

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

        DiagnosticUnnecessary = {
          fg = base0C;
          bg = "NONE";
          blend = 30;
        };
      };
  };
}
