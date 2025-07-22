{ lib, helpers, ... }:
let
  inherit (lib) enabled';
  inherit (helpers) mkRaw;
in
{
  plugins.notify = enabled' {
    settings = {
      fps = 60;
      timeout = 3000;
      stages = "static";
      max_height = mkRaw ''
        function()
          return math.floor(vim.o.lines * 0.75)
        end
      '';
      max_width = mkRaw ''
        function()
          return math.floor(vim.o.columns * 0.75)
        end
      '';
      on_open = mkRaw ''
        function(win)
          vim.api.nvim_win_set_config(win, { zindex = 100 })
        end
      '';
      background_colour = "NotifyBackground";
    };
  };
}
