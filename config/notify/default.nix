{ helpers, ... }:
{
  plugins.notify = {
    enable = true;
    fps = 60;
    timeout = 3000;
    stages = "static";
    maxHeight = helpers.mkRaw ''
      function()
        return math.floor(vim.o.lines * 0.75)
      end
    '';
    maxWidth = helpers.mkRaw ''
      function()
        return math.floor(vim.o.columns * 0.75)
      end
    '';
    onOpen = helpers.mkRaw ''
      function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end
    '';
    backgroundColour = "NotifyBackground";
  };
}
