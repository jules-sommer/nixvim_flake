{
  config,
  lib,
  helpers,
  plugins,
  ...
}:
let
  inherit (lib) mkIf;
  cfg = config.plugins.noice;
in
{
  config = mkIf cfg.enable {

    extraConfigLua = ''
      function DismissAllNotif(state)
        local silent, pending = state.silent, state.pending
        require("notify").dismiss({ silent = silent, pending = pending })
        vim.cmd("Noice dismiss")
      end
    '';

    keymaps = [
      {
        key = "<leader>un";
        action = "<cmd>lua DismissAllNotif({ true, true })<CR>";
        options = {
          desc = "Dismiss all popups via Noice";
          silent = true;
        };
      }
    ];

    # extraPlugins = [ plugins.fzf-lua ];

    plugins.noice = {
      cmdline = {
        enabled = true;
        view = "cmdline_popup";
        format = {
          cmdline = {
            pattern = "^:";
            icon = "||>";
            lang = "vim";
          };
          search_down = {
            kind = "search";
            pattern = "^/";
            icon = " ";
            lang = "regex";
          };
          search_up = {
            kind = "search";
            pattern = "?%?";
            icon = " ";
            lang = "regex";
          };
          filter = {
            pattern = "^:%s*!";
            icon = "$";
            lang = "bash";
          };
          lua = {
            pattern = "^:%s*lua%s+";
            icon = "";
            lang = "lua";
          };
          help = {
            pattern = "^:%s*he?l?p?%s+";
            icon = "?";
          };
          input = { };
        };
      };
      smartMove = {
        enabled = true;
        excludedFiletypes = [
          "cmp_menu"
          "neo-tree"
          "neo-tree-popup"
          "cmp_docs"
          "notify"
        ];
      };
      messages = {
        enabled = true;
        view = "notify";
        viewError = "notify";
        viewHistory = "messages";
        viewSearch = "virtualtext";
        viewWarn = "notify";
      };
      markdown = {
        highlights = {
          "|%S-|" = "@text.reference";
          "@%S+" = "@parameter";
          "^%s*(Parameters:)" = "@text.title";
          "^%s*(Return:)" = "@text.title";
          "^%s*(See also:)" = "@text.title";
          "{%S-}" = "@parameter";
        };
        hover = {
          "|(%S-)|" = "vim.cmd.help";
          "%[.-%]%((%S-)%)" = "require('noice.util').open";
        };
      };
      presets = {
        bottom_search = false;
        command_palette = true;
        long_message_to_split = true;
        inc_rename = true;
        lsp_doc_border = true;
      };
      notify = {
        enabled = config.plugins.notify.enable;
        view = "notify";
      };

      popupmenu = {
        enabled = true;
        backend = "nui";
        kindIcons = true;
      };
      lsp = {
        override = {
          "cmp.entry.get_documentation" = true;
          "vim.lsp.util.convert_input_to_markdown_lines" = true;
          "vim.lsp.util.stylize_markdown" = true;
        };
        documentation = {
          opts = {
            lang = "markdown";
            replace = true;
            render = "plain";
            format = [ "{message}" ];
            win_options = {
              concealcursor = "n";
              conceallevel = 3;
            };
          };
          view = "hover";
        };
        message = {
          enabled = true;
          view = "notify";
        };
        progress = {
          enabled = true;
          format = "lsp_progress";
          formatDone = "lsp_progress";
          throttle = 1000 / 30;
          view = "mini";
        };
        hover.enabled = true;
      };
    };
  };
}
