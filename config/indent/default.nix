{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOpt;
in
{
  options.modules.indent-blankline = mkEnableOpt "Enable indentation and scope rainbow styling.";

  config = {
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
          indent = {
            char = "┆";
            tab_char = "┆";
            inherit highlight;
            priority = 1;
          };
          scope = {
            show_end = false;
            show_exact_scope = false;
            show_start = false;

            inherit highlight;
            priority = 1024;
          };
        };
      };

    highlight =
      let
        colors = {
          blue.fg = "#7aa2f7";
          cyan.fg = "#7dcfff";
          green.fg = "#9ece6a";
          orange.fg = "#ff9e64";
          red.fg = "#f7768e";
          violet.fg = "#9d7cd8";
          yellow.fg = "#e0af68";
          transparent.bg = "NONE";
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
  };
}
