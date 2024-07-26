{ 
 config
, lib
, ...
}:
let
  inherit (lib) mkEnableOption mkIf enabled;
  cfg = config.plugins.hop;
in
{
  config = mkIf cfg.enable
    {
      keymaps = [
        {
          key = "f";
          lua = true;
          action = ''
            function()
              require('hop').hint_char1({
                direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
                current_line_only = true
              })
            end
          '';
          options.noremap = true;
        }
        {
          key = "F";
          lua = true;
          action = ''
            function()
              require('hop').hint_char1({
                direction = require'hop.hint'.HintDirection.BEFORE_CURSOR,
                current_line_only = true
              })
            end
          '';
          options.noremap = true;
        }
        {
          key = "t";
          lua = true;
          action = ''
            function()
              require('hop').hint_char1({
                direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
                current_line_only = true,
                hint_offset = -1
              })
            end
          '';
          options.noremap = true;
        }
        {
          key = "T";
          lua = true;
          action = ''
            function()
              require('hop').hint_char1({
                direction = require'hop.hint'.HintDirection.BEFORE_CURSOR,
                current_line_only = true,
                hint_offset = 1
              })
            end
          '';
          options.noremap = true;
        }
      ];
    };
}
