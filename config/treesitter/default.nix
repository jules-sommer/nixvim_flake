{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf enabled;
  cfg = config.plugins.treesitter;
in
{
  config = mkIf cfg.enable {
    plugins.treesitter = {
      nixGrammars = true;
      nixvimInjections = true;
      settings = {
        indent = {
          enable = true;
        };
      };
    };
    plugins.treesitter-textobjects = {
      enable = true;
      lspInterop = {
        enable = true;
        border = "rounded";
      };
      move = enabled;
      swap = enabled;
      select = enabled;
    };
  };
}
