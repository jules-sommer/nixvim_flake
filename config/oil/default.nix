{
  config,
  lib,
  plugins,
  helpers,
  ...
}:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.plugins.oil;
in
{
  config = mkIf cfg.enable {
    keymaps = [
      {
        key = "<leader>o";
        action = helpers.mkRaw "require('oil').toggle_float";
        options = {
          desc = "Find files using Oil";
          silent = true;
        };
      }
      {
        key = "<leader>oh";
        action = helpers.mkRaw "require('oil').toggle_hidden";
        options = {
          desc = "Toggle hidden files in Oil";
          silent = true;
        };
      }
      {
        key = "<C-c>";
        action = helpers.mkRaw "require('oil').close";
        options = {
          desc = "Close the oil window";
          silent = true;
        };
        mode = [
          "n"
          "s"
        ];
      }
    ];

    plugins.oil = {
      settings = {
        constrain_cursor = "editable";
        default_file_explorer = true;
        experimental_watch_for_changes = false;
        skip_confirm_for_simple_edits = true;
        prompt_save_on_select_new_entry = true;
        delete_to_trash = true;
        float = {
          padding = 3;
          border = "rounded";
        };

        columns = [ "icon" ];

        view_options = {
          show_hidden = false;
        };

        keymaps = {
          "g?" = "actions.show_help";
          "<CR>" = "actions.select";
          "<C-s>" = "actions.select_vsplit";
          "<C-h>" = "actions.select_split";
          "<C-t>" = "actions.select_tab";
          "<C-p>" = "actions.preview";
          "<C-c>" = "actions.close";
          "<C-l>" = false;
          "<C-r>" = "actions.refresh";
          "y." = "actions.copy_entry_path";
          "-" = "actions.parent";
          "_" = "actions.open_cwd";
          " " = "actions.cd";
          "~" = "actions.tcd";
          "gs" = "actions.change_sort";
          "gx" = "actions.open_external";
          "g." = "actions.toggle_hidden";
          "g\\" = "actions.toggle_trash";
        };
      };
    };
  };
}
