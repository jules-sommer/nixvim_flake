{
  config,
  lib,
  helpers,
  ...
}:
with lib;
let
  cfg = config.lsp.rustaceanvim;
in
{
  options.lsp.rustaceanvim = {
    enable = mkEnableOption "Enable rustaceanvim configuration.";
  };

  config = mkIf cfg.enable {
    plugins.rustaceanvim = {
      enable = true;
      settings = {
        server = {
          default_settings = {
            rust-analyzer = {
              checkOnSave = true;
              check = {
                command = "clippy";
                invocationLocation = "workspace";
              };
              completion = {
                autoimport = enabled;
                autoself = enabled;
                callable.snippets = "add_parentheses";
                fullFunctionSignatures = enabled;
                postfix = enabled;
              };
              semanticHighlighting.nonStandardTokens = true;
              diagnostics = {
                enable = true;
                experimental = enabled;
              };
              inlayHints = {
                lifetimeElisionHints = {
                  enable = "always";
                };
              };
            };
          };
          standalone = true;
        };
        tools = {
          float_win_config.open_split = "horizontal";
          hover_actions.replace_builtin_hover = true;
          code_actions = {
            group_icon = " ▶";
            ui_select_fallback = false;
          };
          crate_graph.full = true;
          enable_clippy = true;
          enable_nextest = true;
          reload_workspace_from_cargo_toml = true;
          open_url = helpers.mkRaw ''
            require('rustaceanvim.os').open_url
          '';
        };
      };
    };
  };
}
