{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.lsp.none-ls;
in
{
  options.lsp.none-ls = {
    enable = mkEnableOption "Enable none-ls configuration.";
  };

  config = mkIf cfg.enable {
    plugins = {
      none-ls = enabled' {
        enableLspFormat = true;
        settings = {
          border = "rounded";
        };
        sources = {
          completion = {
            luasnip = enabled;
          };
          code_actions = {
            statix = enabled;
            refactoring = enabled;
          };
          diagnostics = {
            deadnix = enabled;
            statix = enabled;
          };
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
    };
  };
}
