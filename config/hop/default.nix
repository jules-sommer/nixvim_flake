{ 
 config
, lib
, helpers
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
          action = helpers.mkRaw ''
            function()
              require('hop').hint_char1({
                direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
                current_line_only = true
              })
            end
          '';
        }
        {
          key = "F";
          action = helpers.mkRaw ''
            function()
              require('hop').hint_char1({
                direction = require'hop.hint'.HintDirection.BEFORE_CURSOR,
                current_line_only = true
              })
            end
          '';
        }
        {
          key = "t";
          action = helpers.mkRaw ''
            function()
              require('hop').hint_char1({
                direction = require'hop.hint'.HintDirection.AFTER_CURSOR,
                current_line_only = true,
                hint_offset = -1
              })
            end
          '';
        }
        {
          key = "T";
          action = helpers.mkRaw ''
            function()
              require('hop').hint_char1({
                direction = require'hop.hint'.HintDirection.BEFORE_CURSOR,
                current_line_only = true,
                hint_offset = 1
              })
            end
          '';
        }
      ];
    };
}
