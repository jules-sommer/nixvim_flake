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
  options.lsp = {
    enable = mkEnableOption "Enable LSP configuration.";
  };

  config = mkIf cfg.enable {
    plugins = {
      luasnip = enabled;
      improved-search = enabled;
      indent-o-matic = enabled;
      nvim-colorizer = enabled;
      inc-rename = enabled;
      zig = enabled;
      rustaceanvim = enabled;
      none-ls = {
        enable = true;
        sources = {
          formatting = {
            nixfmt = {
              enable = true;
              package = pkgs.nixfmt-rfc-style;
            };
            ocamlformat = {
              enable = true;
              package = pkgs.ocamlformat;
            };
            htmlbeautifier = enabled;
            markdownlint = enabled;
            gofmt = {
              enable = true;
              package = pkgs.gopls;
            };
          };
        };
      };

      nvim-autopairs = enabled;
      comment = enabled;
      nix = enabled;
      crates-nvim = enabled;
      direnv = enabled;
      lsp-lines = enabled;
      lsp-format = enabled;
      nix-develop = enabled;

      lsp = {
        enable = true;
        servers = {
          lua-ls = {
            enable = true;
            settings = {
              telemetry = disabled;
            };
          };
          nushell = enabled;
          tsserver = enabled;
          htmx = enabled;
          zls = enabled;
          rnix-lsp = disabled;
          nixd = disabled;
          nil-ls = enabled;
          bashls = enabled;
          # rust-analyzer = {
          #   enable = true;
          #   installRustc = false;
          #   installCargo = false;
          # };
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
    };

    autoGroups = {
      UserLspConfig = {
        clear = true;
      };
    };

    autoCmd = [
      {
        event = "LspAttach";
        group = "UserLspConfig";
        callback = {
          __raw = ''
            function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              if client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
              end
            end
          '';
        };
      }
    ];

    keymapsOnEvents = {
      InsertEnter = [
        {
          action = helpers.mkRaw ''require("cmp").mapping.confirm()'';
          key = "<C-y>";
        }
        {
          action = helpers.mkRaw ''require("cmp").mapping.select_next_item()'';
          key = "<C-n>";
        }
      ];
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
        (mkIf (incRenameEnabled) {
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

    keymaps = [ ];
  };
}
