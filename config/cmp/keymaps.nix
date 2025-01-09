{ helpers, ... }:
{
  config = {
    plugins.cmp.settings.mapping = {
      "<C-b>" = "cmp.mapping.scroll_docs(-4)";
      "<C-f>" = "cmp.mapping.scroll_docs(4)";
      "<C-Space>" = "cmp.mapping.complete()";
      "<C-c>" = "cmp.mapping.abort()";
      "<C-y>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true })";

      "<C-p>" = "cmp.mapping.select_prev_item()";
      "<C-n>" = "cmp.mapping.select_next_item()";
      "<Up>" = "cmp.mapping.select_prev_item()";
      "<Down>" = "cmp.mapping.select_next_item()";

      "<CR>" = ''
        cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        })
      '';

      "<Tab>" = ''
        cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end 
        end, {'i', 's'})
      '';

      "<S-Tab>" = ''
        cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, {'i', 's'})
      '';

      "<Esc>" = helpers.mkRaw ''
        cmp.mapping(function(fallback)
          -- this is done inline as opposed to conditionally
          -- so that it doesn't block the fallback
          -- i.e will both abort and exit insert mode
          cmp.abort()
          fallback()
        end, {'i', 's'})
      '';
    };
    keymaps = [
      {
        key = "<Tab>";
        action = helpers.mkRaw ''
          function()
            return vim.snippet.active({ direction = 1 }) and "<cmd>lua vim.snippet.jump(1)<cr>" or "<Tab>"
          end
        '';
        mode = [
          "i"
          "s"
        ];
        options = {
          expr = true;
          silent = true;
        };
      }
      {
        key = "<S-Tab>";
        action = helpers.mkRaw ''
          function()
            return vim.snippet.active({ direction = -1 }) and "<cmd>lua vim.snippet.jump(-1)<cr>" or "<S-Tab>"
          end
        '';
        mode = [
          "i"
          "s"
        ];
        options = {
          expr = true;
          silent = true;
        };
      }
    ];
  };
}
