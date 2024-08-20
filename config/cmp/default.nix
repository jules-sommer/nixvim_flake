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
            };
            completion = {
              border = "rounded";
              winhighlight = "FloatBorder:TelescopeBorder,Normal:Pmenu";
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

          asyncPathEnabled = cfgLocal.sources.path == "async";
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
                # default cmp.config.compare
                # "require('cmp.config.compare').offset"
                # "require('cmp.config.compare').exact"
                # "require('cmp.config.compare').score"
                # "require('cmp.config.compare').recently_used"
                # "require('cmp.config.compare').locality"
                # "require('cmp.config.compare').kind"
                # "require('cmp.config.compare').length"
                # "require('cmp.config.compare').order"
              ];
            };

            snippet.expand = ''
              function(args)
                require('luasnip').lsp_expand(args.body)
              end
            '';

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
              (mkIf asyncPathEnabled {
                name = "async_path";
                keyword_length = 2;
              })
              (mkIf (asyncPathEnabled == false) {
                name = "path";
                keyword_length = 2;
              })
              {
                name = "luasnip";
                keywordLength = 3;
              }
            ];

            mapping = {
              "<C-b>" = "cmp.mapping.scroll_docs(-4)";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-c>" = "cmp.mapping.abort()";

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

              "<Esc>" = ''
                cmp.mapping(function(fallback)
                  local sm = require('supermaven-nvim.completion_preview')

                  if cmp.visible() then
                    cmp.abort()
                  end

                  if sm ~= nil and sm.inlay_instance ~= nil then
                    sm.on_dispose_inlay()
                  end

                  fallback()
                end, {'i', 's'})
              '';

              "<C-p>" = "cmp.mapping.select_prev_item()";
              "<C-n>" = "cmp.mapping.select_next_item()";
              "<Up>" = "cmp.mapping.select_prev_item()";
              "<Down>" = "cmp.mapping.select_next_item()";
            };

          };

          # plugins.cmp.cmdline..window.documentation.winhighlight;
          cmdline = {
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
                (mkIf (asyncPathEnabled == true) { name = "async_path"; })
                (mkIf (asyncPathEnabled == false) { name = "path"; })
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
