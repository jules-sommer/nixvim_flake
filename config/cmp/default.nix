{
  config,
  lib,
  helpers,
  ...
}:
let
  inherit (lib)
    mkIf
    enabled
    types
    mkOpt
    ;
  cfg = config.plugins.cmp;
  cfgLocal = config.xeta.cmp;
in
{
  imports = [
    ./keymaps.nix
  ];

  options.xeta.cmp = {
    sources = {
      path = mkOpt (types.enum [
        "async"
        "default"
      ]) "default" "Which source to use for cmp path completion";
    };
  };

  config = mkIf cfg.enable {
    plugins = {
      cmp-treesitter = {
        enable = lib.mkDefault helpers.enableExceptInTests;
      };
      cmp_yanky = enabled;
      cmp-nvim-lsp = enabled;
      cmp-nvim-lua = enabled;

      cmp-cmdline = enabled;
      cmp-nvim-lsp-document-symbol = enabled;
      cmp-nvim-lsp-signature-help = enabled;
      cmp_luasnip = enabled;
      coq-nvim = enabled;
      coq-thirdparty = enabled;
      cmp-calc = enabled;
      cmp-rg = enabled;
      cmp-async-path = mkIf (cfgLocal.sources.path == "async") enabled;

      lspkind = {
        enable = true;
        cmp = enabled;
        mode = "symbol_text";
      };

      cmp =
        let
          window = {
            documentation = {
              border = "rounded";
              winhighlight = "FloatBorder:TelescopeBorder,Normal:Pmenu";
              zindex = 300;
              style = "minimal";
            };

            completion = {
              border = "rounded";
              winhighlight = "FloatBorder:TelescopeBorder,Normal:Pmenu";
              zindex = 300;
              style = "minimal";
            };
          };
          view = {
            entries = {
              name = "custom";
              selection_order = "near_cursor";
            };
            docs = {
              auto_open = true;
            };
          };

          asyncPathEnabled = config.xeta.cmp.sources.path == "async";
        in
        {
          settings = {
            enable = true;
            autoEnableSources = true;

            inherit window;

            performance = {
              debounce = 60;
              fetchingTimeout = 200;
              maxViewEntries = 75;
            };

            sorting = {
              comparators = [
                "require('cmp.config.compare').locality"
                "require('cmp.config.compare').exact"
                "require('cmp.config.compare').kind"
                "require('cmp.config.compare').recently_used"
                "require('cmp.config.compare').offset"
                "require('cmp.config.compare').score"
                "require('cmp.config.compare').length"
                "require('cmp.config.compare').order"
              ];
            };

            snippet.expand = ''
              function(args)
                -- You need Neovim v0.10 to use vim.snippet
                vim.snippet.expand(args.body)
              end
            '';

            experimental = {
              native_menu = false;
            };

            sources = [
              {
                name = "nvim_lsp";
                keyword_length = 0;
              }
              {
                name = "nvim_lsp_document_symbol";
                keyword_length = 0;
              }
              {
                name = "nvim_lsp_signature_help";
                keyword_length = 0;
              }
              {
                name = "treesitter";
                keyword_length = 0;
              }
              {
                name = "luasnip";
                keywordLength = 1;
              }
              (mkIf asyncPathEnabled {
                name = "async_path";
                keyword_length = 1;
              })
              (mkIf (!asyncPathEnabled) {
                name = "path";
                keyword_length = 1;
              })
            ];

          };

          # plugins.cmp.cmdline..window.documentation.winhighlight;
          cmdline = {
            inherit window view;
            "/" = {
              inherit window view;
              mapping = helpers.mkRaw "cmp.mapping.preset.cmdline()";
              sources = [
                { name = "buffer"; }
                { name = "rg"; }
              ];
            };
            ":" = {
              inherit window view;
              mapping = helpers.mkRaw "cmp.mapping.preset.cmdline()";
              sources = [
                (mkIf asyncPathEnabled { name = "async_path"; })
                (mkIf (!asyncPathEnabled) { name = "path"; })
                {
                  name = "cmdline";
                  option = {
                    ignore_cmds = [
                      "Man"
                      "!"
                    ];
                  };
                }
              ];
            };
          };
        };
    };
  };
}
