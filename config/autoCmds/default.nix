{ helpers, ... }:
{
  autoGroups =
    let
      ### This function creates auto autoGroups
      ### with the default value of { clear = true; }
      ### is most commonly used in this config
      createAutoGroups =
        groupNames:
        builtins.listToAttrs (
          map (name: {
            inherit name;
            value = {
              clear = true;
            };
          }) groupNames
        );
    in
    createAutoGroups [
      "CheckTime"
      "HighlightYank"
      "ResizeSplits"
      "LastLoc"
      "CloseWithQ"
      "ManUnlisted"
      "WrapSpell"
      "JsonConceal"
      "AutoCreateDir"
      "Bigfile"
    ];

  autoCmd = [
    # TODO: Update all descriptions of autoGroups
    {
      # pattern = "tostring(vim.api.nvim_get_current_win())";
      event = "WinClosed";
      once = true;
      pattern = "1000";
      callback = helpers.mkRaw ''
        function()
          vim.schedule(function()
            require("startup").display(true)
          end)
        end
      '';
      desc = "open dashboard after closing lazy";
    }
    {
      event = "FileType";
      pattern = [
        "alpha"
        "dashboard"
        "fzf"
        "help"
        "lazy"
        "lazyterm"
        "mason"
        "neo-tree"
        "notify"
        "toggleterm"
        "Trouble"
        "trouble"
      ];
      callback = helpers.mkRaw ''
        function()
          vim.b.miniindentscope_disable = true
        end
      '';
    }
    {
      event = [
        "FileType"
      ];
      pattern = "bigfile";
      callback = helpers.mkRaw ''
        function(ev)
          vim.b.minianimate_disable = true
          vim.schedule(function()
            vim.bo[ev.buf].syntax = vim.filetype.match({ buf = ev.buf }) or ""
          end)
        end
      '';
    }
    {
      event = [
        "BufWritePre"
      ];
      group = "AutoCreateDir";
      callback = helpers.mkRaw ''
        function(event)
          if event.match:match("^%w%w+:[\\/][\\/]") then
            return
          end
          local file = vim.uv.fs_realpath(event.match) or event.match
          vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
        end
      '';
      desc = "Auto create dir when saving a file, in case some intermediate directory does not exist";
    }
    {
      event = [
        "FileType"
      ];
      group = "WrapSpell";
      pattern = [
        "text"
        "plaintex"
        "typst"
        "gitcommit"
        "markdown"
      ];
      callback = helpers.mkRaw ''
        function()
          vim.opt_local.wrap = true
          vim.opt_local.spell = true
        end
      '';
      desc = "wrap and check for spell in text filetypes";
    }
    {
      event = [
        "FileType"
      ];
      group = "JsonConceal";
      pattern = [
        "json"
        "jsonc"
        "json5"
      ];
      callback = helpers.mkRaw ''
        function()
          vim.opt_local.conceallevel = 0
        end
      '';
      desc = "go to last loc when opening a buffer";
    }
    {
      event = "FileType";
      pattern = [ "man" ];
      group = "ManUnlisted";
      callback = helpers.mkRaw ''
        function(event)
          vim.bo[event.buf].buflisted = false
        end
      '';
    }
    {
      event = [
        "FileType"
      ];
      group = "CloseWithQ";
      pattern = [
        "PlenaryTestPopup"
        "grug-far"
        "help"
        "lspinfo"
        "notify"
        "qf"
        "spectre_panel"
        "startuptime"
        "tsplayground"
        "neotest-output"
        "checkhealth"
        "neotest-summary"
        "neotest-output-panel"
        "dbout"
        "gitsigns.blame"
      ];
      callback = helpers.mkRaw ''
        function(event)
          vim.bo[event.buf].buflisted = false
          vim.keymap.set("n", "q", "<cmd>close<cr>", {
            buffer = event.buf,
            silent = true,
            desc = "Quit buffer",
          })
        end
      '';
      desc = "go to last loc when opening a buffer";
    }
    {
      event = [
        "BufReadPost"
      ];
      group = "LastLoc";
      callback = helpers.mkRaw ''
        function(event)
          local exclude = { "gitcommit" }
          local buf = event.buf
          if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
            return
          end
          vim.b[buf].lazyvim_last_loc = true
          local mark = vim.api.nvim_buf_get_mark(buf, '"')
          local lcount = vim.api.nvim_buf_line_count(buf)
          if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
          end
        end
      '';
      desc = "go to last loc when opening a buffer";
    }
    {
      event = [
        "VimResized"
      ];
      group = "ResizeSplits";
      callback = helpers.mkRaw ''
        function()
          local current_tab = vim.fn.tabpagenr()
          vim.cmd("tabdo wincmd =")
          vim.cmd("tabnext " .. current_tab)
        end
      '';
      desc = "resize splits if window got resized";
    }
    {
      event = [
        "TextYankPost"
      ];
      group = "HighlightYank";
      callback = helpers.mkRaw ''
        function()
          vim.highlight.on_yank()
        end
      '';
      desc = "Check if we need to reload the file when it changed";
    }
    {
      event = [
        "FocusGained"
        "TermClose"
        "TermLeave"
      ];
      group = "CheckTime";
      callback = helpers.mkRaw ''
        function()
          if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
          end
        end
      '';
      desc = "Check if we need to reload the file when it changed";
    }
    {
      event = [
        "CursorHold"
        "CursorHoldI"
      ];
      group = "CodeActionSign";
      callback = helpers.mkRaw ''
        function()
          local CA = require('code_action_utils')

          if CA ~= nil then
            CA.ignore_buf_patterns(
              function()
                CA.code_action_listener()
              end,
              CA.ignore_patterns
            )
          end
        end
      '';
    }
    {
      event = "LspAttach";
      group = "UserLspConfig";
      callback = helpers.mkRaw ''
        function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client.server_capabilities.inlayHintProvider then
            vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
          end
        end
      '';
    }
  ];
}
