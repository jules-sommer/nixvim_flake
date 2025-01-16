{
  config,
  pkgs,
  lib,
  helpers,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    enabled
    disabled
    ;

  cfg = config.lsp;
  incRenameEnabled = config.plugins.inc-rename.enable;
in
{
  imports = [
    ./none-ls
    ./rustacean-nvim
  ];

  options.lsp = {
    enable = mkEnableOption "Enable LSP configuration.";
  };

  config = mkIf cfg.enable {
    plugins = {
      trouble = disabled;
      lsp = {
        enable = true;
        servers = {
          lua_ls = {
            enable = true;
            settings = {
              telemetry = disabled;
            };
          };
          ts_ls = enabled;
          htmx = enabled;
          zls = {
            enable = true;
            autostart = true;
            package = pkgs.zls;
            settings = {
              enable_build_on_save = true;
              enable_autofix = true;
              build_on_save_step = "check";
              build_runner_path = "${pkgs.zls.src}/src/build_runner/master.zig";
              warn_style = true;
              highlight_global_var_declarations = true;
            };
          };
          nixd = disabled;
          nil_ls = {
            enable = true;
            autostart = true;
          };
          bashls = enabled;
          fish_lsp = {
            enable = true;
            package = pkgs.fish-lsp;
          };
          html = enabled;
          ccls = enabled;
          cmake = enabled;
          cssls = enabled;
          gopls = enabled;
          jsonls = enabled;
          pyright = enabled;
          tailwindcss = enabled;
        };
      };

      luasnip = enabled;
      improved-search = enabled;
      indent-o-matic = enabled;
      colorizer = enabled;
      inc-rename = enabled;
      zig = enabled;
      nvim-autopairs = enabled;
      comment = disabled;
      nix = enabled;
      crates = enabled;
      direnv = enabled;
      lsp-lines = enabled;
      lsp-format = enabled;
      nix-develop = enabled;
    };

    extraConfigLuaPost = ''
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local lspconfig = require('lspconfig')

      local servers = { 'clangd', 'pyright', 'ts_ls' }
      for _, lsp in ipairs(servers) do
        if lspconfig[lsp] ~= nil then
          lspconfig[lsp].setup {
            capabilities = capabilities,
          }
        end
      end
    '';

    extraFiles = {
      "lua/code_action_utils.lua" = {
        enable = true;
        text = ''
          local M = {}

          local lsp_util = vim.lsp.util

          M.ignore_patterns = {
            "startify",
            "dashboard",
            "lazygit",
            "neogitstatus",
            "NvimTree",
            "Outline",
            "spectre_panel",
            "toggleterm",
            "Trouble",
            "startup",
            "help",
            "mason",
            "lazy",
          }

          function M.ignore_buf_patterns(callback, patterns)
            local current_buffer_name = vim.api.nvim_buf_get_name(0)
            for _, pattern in ipairs(patterns) do
              if current_buffer_name:match(pattern) then
                if callback then
                  callback()
                else 
                  return 
                end
              end
            end
          end

          function M.code_action_listener()
            local context = { diagnostics = vim.diagnostic.get() }
            local params = lsp_util.make_range_params()
            params.context = context
            vim.lsp.buf_request(0, 'textDocument/codeAction', params, function(err, result, ctx, config)
              vim.notify(vim.inspect(result), vim.inspect(ctx), vim.inspect(config))
            end)
          end

          return M
        '';
      };
    };

    autoGroups = {
      UserLspConfig = {
        clear = true;
      };
      CodeActionSign = {
        clear = true;
      };
    };

    autoCmd = [
      {
        event = [
          "CursorHold"
          "CursorHoldI"
        ];
        group = "CodeActionSign";
        callback = helpers.mkRaw ''
          function()
            local M = require('code_action_utils')

            M.ignore_buf_patterns(
              function()
                require('code_action_utils').code_action_listener()
              end,
              M.ignore_patterns
            )
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

    keymapsOnEvents = {
      LspAttach = [
        {
          key = "<leader>l";
          action = helpers.mkRaw "require('lsp_lines').toggle";
          options = {
            desc = "Toggle LSP virtual line diagnostics";
            buffer = true;
          };
        }
        {
          key = "gD";
          action = helpers.mkRaw "vim.lsp.buf.declaration";
          options = {
            desc = "Go to declaration";
          };
        }
        {
          key = "<leader>ca";
          action = helpers.mkRaw "vim.lsp.buf.code_action";
          options = {
            desc = "See available code actions";
          };
        }
        (mkIf incRenameEnabled {
          key = "<leader>rn";
          action = helpers.mkRaw "vim.lsp.buf.rename";
          options = {
            desc = "Semi-intelligent rename via LSP";
          };
        })
        (mkIf (!incRenameEnabled) {
          key = "<leader>rn";
          action = "<cmd>IncRename<CR>";
          options = {
            desc = "Smart rename via IncRename and LSP";
          };
        })
        {
          key = "<leader>d";
          action = helpers.mkRaw "vim.diagnostic.open_float";
          options = {
            desc = "Show line diagnostics";
          };
        }
        {
          key = "[d";
          action = helpers.mkRaw "vim.diagnostic.goto_prev";
          options = {
            desc = "Go to previous diagnostic";
          };
        }
        {
          key = "]d";
          action = helpers.mkRaw "vim.diagnostic.goto_next";
          options = {
            desc = "Go to next diagnostic";
          };
        }
        {
          key = "K";
          action = helpers.mkRaw "vim.lsp.buf.hover";
          options = {
            desc = "Show documentation for what is under cursor";
          };
        }
        {
          key = "<leader>rs";
          action = "<cmd>LspRestart<CR>";
          options = {
            desc = "Restart LSP";
          };
        }
        {
          key = "gD";
          action = helpers.mkRaw "vim.lsp.buf.declaration";
          options = {
            desc = "Jump to declaration";
            buffer = true;
          };
        }
        {
          key = "gi";
          action = helpers.mkRaw "vim.lsp.buf.implementation";
          options = {
            desc = "Lists all the implementations for the symbol under the cursor";
            buffer = true;
          };
        }
        {
          key = "go";
          action = helpers.mkRaw "vim.lsp.buf.type_definition";
          options = {
            desc = "Jumps to the definition of the type symbol";
            buffer = true;
          };
        }
        {
          key = "gr";
          action = helpers.mkRaw "vim.lsp.buf.references";
          options = {
            desc = "Lists all the references";
            buffer = true;
          };
        }
        {
          key = "gs";
          action = helpers.mkRaw "vim.lsp.buf.signature_help";
          options = {
            desc = "Displays a function's signature information";
            buffer = true;
          };
        }
        {
          key = "<F2>";
          action = helpers.mkRaw "vim.lsp.buf.rename";
          options = {
            desc = "Renames all references to the symbol under the cursor";
            buffer = true;
          };
        }
        {
          key = "<F4>";
          action = helpers.mkRaw "vim.lsp.buf.code_action";
          options = {
            desc = "Selects a code action available at the current cursor position";
            buffer = true;
          };
        }
        {
          key = "gl";
          action = helpers.mkRaw "vim.diagnostic.open_float";
          options = {
            desc = "Show diagnostics in a floating window";
            buffer = true;
          };
        }
      ];
    };

    keymaps = [
      {
        key = "[q";
        action = helpers.mkRaw ''
          function()
            if require("trouble").is_open() then
              require("trouble").prev({ skip_groups = true, jump = true })
            else
              local ok, err = pcall(vim.cmd.cprev)
              if not ok then
                vim.notify(err, vim.log.levels.ERROR)
              end
            end
          end
        '';
        options = {
          desc = "Previous Trouble/Quickfix Item";
        };
      }
      {
        key = "]q";
        action = helpers.mkRaw ''
          function()
            if require("trouble").is_open() then
              require("trouble").next({ skip_groups = true, jump = true })
            else
              local ok, err = pcall(vim.cmd.cnext)
              if not ok then
                vim.notify(err, vim.log.levels.ERROR)
              end
            end
          end
        '';
        options = {
          desc = "Next Trouble/Quickfix Item";
        };
      }
      {
        key = "<leader>xx";
        action = "<cmd>Trouble diagnostics toggle<cr>";
        options = {
          desc = "Diagnostics (Trouble)";
        };
      }
      {
        key = "<leader>xX";
        action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
        options = {
          desc = "Buffer Diagnostics (Trouble)";
        };
      }
      {
        key = "<leader>cs";
        action = "<cmd>Trouble symbols toggle<cr>";
        options = {
          desc = "Symbols (Trouble)";
        };
      }
      {
        key = "<leader>cS";
        action = "<cmd>Trouble lsp toggle<cr>";
        options = {
          desc = "LSP references/definitions/... (Trouble)";
        };
      }
      {
        key = "<leader>xL";
        action = "<cmd>Trouble loclist toggle<cr>";
        options = {
          desc = "Location List (Trouble)";
        };
      }
      {
        key = "<leader>xQ";
        action = "<cmd>Trouble qflist toggle<cr>";
        options = {
          desc = "Quickfix List (Trouble)";
        };
      }
    ];
  };
}
