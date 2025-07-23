{
  config,
  pkgs,
  helpers,
  lib,
  ...
}:
let
  inherit (lib) mkIf enabled enabled';
  inherit (pkgs.vimPlugins.nvim-treesitter) builtGrammars;
  cfg = config.plugins.treesitter;
in
{
  config = mkIf cfg.enable {
    plugins = {
      treesitter = {
        grammarPackages = with builtGrammars; [
          bash
          fish
          json
          lua
          make
          markdown
          ziggy
          ziggy_schema
          nix
          regex
          toml
          vim
          vimdoc
          xml
          yaml
        ];

        settings = {
          auto_install = false;
          ensure_installed = [
            "fish"
            "ziggy"
            "nix"
            "vim"
            "git_config"
            "git_rebase"
            "gitattributes"
            "gitcommit"
            "gitignore"
          ];
        };
      };

      treesitter-textobjects = enabled' {
        lspInterop = {
          enable = true;
          border = "rounded";
        };
        move = enabled;
        swap = enabled;
        select = enabled;
      };
    };
  };
}
