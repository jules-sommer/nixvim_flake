{
  config,
  lib,
  helpers,
  ...
}:
let
  inherit (lib) mkIf enabled;
  cfg = config.plugins.telescope;
in
{
  config = mkIf cfg.enable {
    plugins = {
      telescope = {
        settings = {
          pickers = {
            find_files = {
              find_command = [
                "rg"
                "--files"
                # "--hidden"
                "--glob"
                "!**/.git/*"
              ];
            };
          };

          defaults = {
            vimgrep_arguments = [
              "rg"
              "--color=never"
              "--no-heading"
              "--with-filename"
              "--line-number"
              "--column"
              "--smart-case"
              "--trim"
            ];
          };
        };

        extensions = {
          frecency = {
            enable = true;
            settings = {
              db_root = helpers.mkRaw "vim.fn.stdpath 'data'";
              disable_devicons = false;
              db_safe_mode = false;
              ignore_patterns = [
                "*.git/*"
                "*/tmp/*"
                "*/.cache/*"
                "*/.zig-cache/*"
                ".zig-cache/*"
                ".*"
                "*/.*"
              ];
              show_scores = true;
              show_unindexed = true;
            };
          };
          fzf-native = {
            enable = true;
            settings = {
              case_mode = "smart_case";
              fuzzy = true;
              override_file_sorter = true;
              override_generic_sorter = true;
            };
          };
          media-files = {
            enable = true;
            settings = {
              filetypes = [
                "png"
                "webp"
                "jpg"
                "jpeg"
              ];
              find_cmd = "rg";
            };
          };
          ui-select = enabled;
          file-browser = enabled;
          manix = enabled;
        };
        keymaps = { };
      };
    };
    keymaps = [
      {
        key = "<space>f";
        action = "<cmd>Telescope find_files<CR>";
        options = {
          desc = "Find files using Telescope";
          noremap = true;
          unique = true;
        };
      }
      {
        key = "<leader>k";
        action = "<cmd>Telescope keymaps<CR>";
        options = {
          desc = "Find keymaps using Telescope";
          noremap = true;
          unique = true;
        };
      }
      {
        key = "<leader>c";
        action = "<cmd>Telescope commands<CR>";
        options = {
          desc = "Find commands using Telescope";
          noremap = true;
          unique = true;
        };
      }
      {
        key = "<leader>t";
        action = "<cmd>Telescope registers<CR>";
        options = {
          desc = "Find registers using Telescope";
          noremap = true;
          unique = true;
        };
      }
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<leader>g";
        options = {
          desc = "Live grep in current directory";
          noremap = true;
          unique = true;
        };
      }
      {
        action = "<cmd>Telescope help_tags<CR>";
        key = "<leader>h";
        options = {
          desc = "Search help tags with Telescope";
          noremap = true;
          unique = true;
        };
      }
      {
        action = "<cmd>Telescope buffers<CR>";
        key = "<leader>b";
        options = {
          desc = "List open buffers with Telescope";
          noremap = true;
          unique = true;
        };
      }
      {
        action = "<cmd>Telescope current_buffer_fuzzy_find<CR>";
        key = "<leader>/";
        options = {
          desc = "Fuzzy find in current buffer with Telescope";
          noremap = true;
          unique = true;
        };
      }
      {
        action = "<cmd>Telescope lsp_references<CR>";
        key = "gR";
        options = {
          noremap = true;
          desc = "Show LSP references";
        };
      }
      {
        key = "gd";
        action = "<cmd>Telescope lsp_definitions<CR>";
        options = {
          noremap = true;
          desc = "Show LSP definitions";
        };
      }
      {
        key = "gi";
        action = "<cmd>Telescope lsp_implementations<CR>";
        options = {
          noremap = true;
          desc = "Show LSP implementations";
        };
      }
      {
        key = "gt";
        action = "<cmd>Telescope lsp_type_definitions<CR>";
        options = {
          noremap = true;
          desc = "Show LSP type definitions";
        };
      }
      {
        action = "<cmd>Telescope diagnostics bufnr=0<CR>";
        key = "<leader>d";
        options = {
          noremap = true;
          desc = "Show buffer diagnostics";
        };
      }
    ];
  };
}
