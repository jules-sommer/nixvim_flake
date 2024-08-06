{
  pkgs,
  config,
  lib,
  inputs,
  plugins,
  helpers,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf enabled;
  inherit (plugins) treesitter-nu;

  cfg = config.plugins.treesitter;
in
{
  config = mkIf cfg.enable {
    plugins.treesitter = {
      nixGrammars = true;
      nixvimInjections = true;
      languageRegister = {
        nu = [ "nu" ];
      };
      grammarPackages = plugins.nvim-treesitter.passthru.allGrammars ++ [ treesitter-nu ];
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
    extraFiles = {
      "queries/nu/highlights.scm" = {
        enable = true;
        source = "${treesitter-nu}/queries/nu/highlights.scm";
      };
      "queries/nu/injections.scm" = {
        enable = true;
        source = "${treesitter-nu}/queries/nu/injections.scm";
      };
      # "queries/nu/injections.scm" = builtins.readFile "${treesitter-nu}/queries/nu/injections.scm";
    };
  };
}
