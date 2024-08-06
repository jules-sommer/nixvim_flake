{
  config,
  pkgs,
  lib,
  helpers,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf enabled disabled;

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

    keymaps = [
      {
        key = "<leader>l";
        action = helpers.mkRaw "require('lsp_lines').toggle";
        options = {
          desc = "Toggle LSP virtual line diagnostics";
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
    ];
  };
}
