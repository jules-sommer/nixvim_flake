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

  cfg = config.xeta.nixvim.plugins.treesitter;
in
{
  options.xeta.nixvim.plugins.treesitter = {
    enable = mkEnableOption "enable treesitter";
  };

  config = mkIf cfg.enable {
    plugins.treesitter = {
      enable = true;
      nixGrammars = true;
      nixvimInjections = true;
      indent = true;
      languageRegister.nu = "nu";
      parserInstallDir = "~/.local/share/treesitter/parsers";
      grammarPackages = plugins.nvim-treesitter.passthru.allGrammars ++ [ treesitter-nu ];
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
      "queries/nu/highlights.scm" = builtins.readFile "${treesitter-nu}/queries/nu/highlights.scm";
      "queries/nu/injections.scm" = builtins.readFile "${treesitter-nu}/queries/nu/injections.scm";
    };
  };
}
