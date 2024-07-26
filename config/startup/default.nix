{
  config,
  lib,
  helpers,
  pkgs,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.plugins.startup;
in
{
  config = mkIf cfg.enable {
    plugins.startup = {
      options = {
        disableStatuslines = true;
        mappingKeys = true;
        paddings = [
          5
          5
        ];
      };
      parts = [
        "header"
        "body"
      ];
      colors = {
        background = "transparent";
      };
      userMappings = {
        ";;" = "<cmd>w<CR>";
        "<leader>ff" = "<cmd>lua CloseAndSaveBuffer()<CR>";
        "<leader>n" = "<cmd>enew<CR>";
        "<leader>o" = "<cmd>lua require('oil').toggle_float()<CR>";
        "<leader>lg" = "<cmd>LazyGit<CR>";
        "<leader>f" = "<cmd>Telescope find_files<CR>";
        "<leader>g" = "<cmd>Telescope live_grep<CR>";
        "<leader>b" = "<cmd>Telescope buffers<CR>";
        "<leader>k" = "<cmd>Telescope keymaps<CR>";
        "<leader>fr" = "<cmd>Telescope registers<CR>";
      };

      sections = {
        body = {
          align = "center";
          content = [
            [
              "Quick find file"
              "Telescope find_files"
              "<leader>f"
            ]
            [
              "Interactive file tree buffer"
              "lua require('oil').toggle_float()"
              "<leader>o"
            ]
            [
              "Create new buffer"
              "enew"
              "<leader>n"
            ]
            [
              "Find Word"
              "Telescope live_grep"
              "<leader>g"
            ]
            [
              "Find Buffer"
              "Telescope buffers"
              "<leader>b"
            ]
            [
              "Open LazyGit"
              "LazyGit"
              "<leader>k"
            ]
            [
              "Find Keymap"
              "Telescope keymaps"
              "<leader>k"
            ]
          ];
          defaultColor = "#FFC0FA";
          foldSection = false;
          highlight = "String";
          margin = 5;
          oldfilesAmount = 5;
          title = "Commands";
          type = "mapping";
        };
        header = {
          align = "center";
          content = helpers.mkRaw ''
            require('startup.headers').neovim_logo_header
          '';
          defaultColor = "#ffffff";
          foldSection = false;
          highlight = "Statement";
          margin = 5;
          oldfilesAmount = 0;
          title = "header";
          type = "text";
        };
      };
    };
  };
}
