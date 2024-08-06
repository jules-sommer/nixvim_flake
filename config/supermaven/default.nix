{
  plugins,
  lib,
  config,
  helpers,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOpt
    types
    ;
  cfg = config.plugins.supermaven;
in
{
  options.plugins.supermaven = {
    enable = mkEnableOption "Enable supermaven-nvim virtual text AI completions.";
    settings = {
      inline-completion = {
        enable = mkEnableOption "Enable/ disable inline completion ( i.e to use with cmp ).";
        suggestion-color = mkOpt (types.nullOr types.str) null "Color of the suggestion.";
      };
      keymaps = {
        enable = mkEnableOption "Enable/ disable default keymaps.";
        accept-suggestion =
          mkOpt (types.nullOr types.str) null
            "Mapping to accept a suggestion in it's entirety ( e.g. `<Tab>` ).";
        clear-suggestion =
          mkOpt (types.nullOr types.str) null
            "Mapping to clear the visible suggestion ( e.g. `<C-c>` ).";
        accept-word =
          mkOpt (types.nullOr types.str) null
            "Mapping to accept a suggestion stepwise by word ( e.g. `<C-j>` ).";
        toggle-inline-completion =
          mkOpt (types.nullOr types.str) null
            "Mapping to toggle inline completion ( e.g. `<leader>s` ).";
      };
    };
  };

  config = mkIf (cfg.enable && helpers.enableExceptInTests) {
    keymaps = [
      {
        key = cfg.settings.keymaps.toggle-inline-completion;
        action = "<cmd>SupermavenToggle<CR>";
        options = {
          silent = true;
          desc = "Toggle inline completion via supermaven-nvim";
        };
      }
    ];

    extraConfigLua = ''
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "${cfg.settings.keymaps.accept-suggestion}",
          clear_suggestion = "${cfg.settings.keymaps.clear-suggestion}",
          accept_word = "${cfg.settings.keymaps.accept-word}",
        },
        ignore_filetypes = { Startup = true },
        color = {
          suggestion_color = "${cfg.settings.inline-completion.suggestion-color}",
          cterm = 244,
        },
        log_level = "info", -- set to "off" to disable logging completely
        disable_inline_completion = ${
          if cfg.settings.inline-completion.enable then "false" else "true"
        }, -- disables inline completion for use with cmp
        disable_keymaps = ${
          if cfg.settings.keymaps.enable then "false" else "true"
        }, -- disables built in keymaps for more manual control
      })
    '';
  };
}
