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
    enabled'
    disabled
    ;

  cfg = config.modules.lsp;
in
{

  options.modules.lsp = {
    enable = mkEnableOption "Enable LSP configuration.";
  };

  config = mkIf cfg.enable {
    plugins = {
      tailwind-tools = enabled' {
        settings = {
          server = {
            override = true;
            settings = {
              server = {
                override = true;
                on_attach = ''
                  function(client, bufnr)
                    print("Attached `", client, "` to bufnr: ", bufnr)
                  end
                '';
              };
              document_color = {
                enabled = true;
                kind = "inline";
                inline_symbol = "󰝤 ";
                debounce = 200;
              };
            };
          };
        };
      };
      conform-nvim = disabled;
      # lint = enabled' {
      #   autoLoad = true;
      #   autoCmd = {
      #     callback = {
      #       __raw = ''
      #         function()
      #           require('lint').try_lint()
      #         end
      #       '';
      #     };
      #     event = "BufWritePost";
      #   };
      # };
      trouble = enabled;
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          # tailwindcss = enabled' {
          #   autostart = true;
          #   rootDir = ''
          #     function(fname)
          #       print("brooooooooooooooo")
          #       print(fname)
          #     end
          #   '';
          # };
          lua_ls = {
            enable = true;
            settings = {
              telemetry = disabled;
            };
          };
          ts_ls = enabled;
          taplo = enabled' {
            autostart = true;
          };
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
            settings = {
              formatting.command = [ "nixfmt" ];
            };
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
        };
      };
      luasnip = enabled;
      improved-search = enabled;
      indent-o-matic = enabled;
      colorizer = enabled;
      inc-rename = enabled;
      zig = enabled;
      nix = enabled;
      crates = enabled;
      direnv = enabled;
      lsp-lines = enabled;
      lsp-format = enabled;
      nix-develop = enabled;
    };

    autoGroups = {
      UserLspConfig = {
        clear = true;
      };
      CodeActionSign = {
        clear = true;
      };
    };

    keymapsOnEvents = {
      LspAttach = [
        (mkIf config.plugins.lsp-lines.enable {
          key = "<leader>l";
          action = helpers.mkRaw ''
            function()
              local has_lsp_lines, lsp_lines = pcall(require, "lsp_lines")
              if not has_lsp_lines then
                vim.notify("lsp_lines not found.", vim.log.levels.WARN)
                return
              end
              lsp_lines.toggle()
            end
          '';
          options = {
            desc = "Toggle LSP virtual line diagnostics";
            buffer = true;
          };
        })
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
        (mkIf config.plugins.inc-rename.enable {
          key = "<leader>rn";
          action = helpers.mkRaw "vim.lsp.buf.rename";
          options = {
            desc = "Semi-intelligent rename via LSP";
          };
        })
        (mkIf (!config.plugins.inc-rename.enable) {
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
