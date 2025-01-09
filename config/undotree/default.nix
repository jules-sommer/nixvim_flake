{ config, lib, ... }:
let
  inherit (lib) mkIf;
  cfg = config.plugins.undotree;
in
{
  config = mkIf cfg.enable {
    plugins.undotree = {
      settings = {
        CursorLine = true;
        DiffAutoOpen = true;
        DiffCommand = "diff";
        DiffpanelHeight = 10;
        HelpLine = true;
        HighlightChangedText = true;
        HighlightChangedWithSign = true;
        HighlightSyntaxAdd = "DiffAdd";
        HighlightSyntaxChange = "DiffChange";
        HighlightSyntaxDel = "DiffDelete";
        RelativeTimestamp = true;
        SetFocusWhenToggle = true;
        ShortIndicators = false;
        SplitWidth = 40;
        TreeNodeShape = "*";
        TreeReturnShape = "\\";
        TreeSplitShape = "/";
        TreeVertShape = "|";
        WindowLayout = 4;
      };
    };
    keymaps = [
      {
        key = "<leader>u";
        action = "<cmd>UndotreeToggle<CR>";
        options.desc = "Toggle undotree";
      }
    ];
  };
}
