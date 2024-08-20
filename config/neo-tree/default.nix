{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.plugins.neo-tree;
in

{
  config = mkIf (cfg.enable) {
    plugins.neo-tree = {
      enableDiagnostics = true;
      enableGitStatus = true;
      enableModifiedMarkers = true;
      enableRefreshOnWrite = true;
      closeIfLastWindow = true;
      defaultSource = "filesystem";
      popupBorderStyle = "rounded";

      gitStatusAsync = true;
      hideRootNode = false;
      sources = [
        "filesystem"
        "buffers"
        "git_status"
      ];

      buffers = {
        bindToCwd = true;
        groupEmptyDirs = true;
      };

      # openFilesDoNotReplaceTypes = [
      #   "terminal"
      #   "Trouble"
      #   "qf"
      #   "edgy"
      # ];

      eventHandlers = {
        before_render = ''
          function (state)
            -- add something to the state that can be used by custom components
          end
        '';

        file_opened = ''
          function(file_path)
            --auto close
            require("neo-tree").close_all()
          end
        '';
      };

      sourceSelector = {
        winbar = true;
        statusline = true;
        contentLayout = "focus";
        separator = "";
      };

      defaultComponentConfigs = {
        gitStatus = {
          symbols = {
            added = "✚";
            modified = "";
            deleted = "✖";
            renamed = "󰁕";
            untracked = "";
            ignored = "";
            unstaged = "󰄱";
            staged = "";
            conflict = "";
          };
        };
      };

      window = {
        width = 36;
        autoExpandWidth = false;
        mappings = {
          "<esc>" = "nohl";
          "<space>" = "noop";
          "<tab>" = ''
            function(state)
              local node = state.tree:get_node()
              if require("neo-tree.utils").is_expandable(node) then
                state.commands["toggle_node"](state)
              else
                state.commands["open_with_window_picker"](state)
                vim.cmd("Neotree reveal")
              end
            end
          '';
          "t" = "open_tabnew";
          "s" = "split_with_window_picker";
          "v" = "vsplit_with_window_picker";
          "C" = "close_node";
          "a" = {
            command = "add";
            config = {
              showPath = "relative";
            };
          };
          "h" = "";
          "l" = "";
          "z" = "none";
          "zo" = "neotree_zo";
          "zO" = "neotree_zO";
          "zc" = "neotree_zc";
          "zC" = "neotree_zC";
          "za" = "neotree_za";
          "zA" = "neotree_zA";
          "zx" = "neotree_zx";
          "zX" = "neotree_zX";
          "zm" = "neotree_zm";
          "zM" = "neotree_zM";
          "zr" = "neotree_zr";
          "zR" = "neotree_zR";
          "<m-h>" = "none";
          "<m-j>" = "none";
          "<m-k>" = "none";
          "<m-l>" = "none";
        };
      };

      filesystem = {
        asyncDirectoryScan = "auto";
        bindToCwd = true;
        filteredItems = {
          visible = true;
          hideDotfiles = true;
          hideGitignored = false;
          hideHidden = true;
          neverShow = [
            ".DS_Store"
            "thumbs.db"
          ];
        };
        hijackNetrwBehavior = "disabled";
        useLibuvFileWatcher = false;
        window = {
          mappings = {
            "H" = "toggle_hidden";
            "D" = "fuzzy_finder_directory";
            #   # "/" = "filter_as_you_type"; # this was the default until v1.28
            #   "#" = "fuzzy_sorter"; # fuzzy sorting using the fzy algorithm
            #   # D = "fuzzy_sorter_directory";
            #   f = "filter_on_submit";
            "<C-x>" = "clear_filter";
            #   "<bs>" = "navigate_up";
            "." = "set_root";
            #   "[g" = "prev_git_modified";
            #   "]g" = "next_git_modified";
            "i" = "run_command";
            "[c" = "prev_git_modified";
            "]c" = "next_git_modified";
            "gA" = "git_add_all";
            "gu" = "git_unstage_file";
            "ga" = "git_add_file";
            "gr" = "git_revert_file";
            "gc" = "git_commit";
            "gp" = "git_push";
            "gg" = "git_commit_and_push";
            "/" = "none";
            "<leader>ip" = "image_preview";
          };
        };
        # commands = {
        #   runCommand = ''
        #     function(state)
        #       local node = state.tree:get_node()
        #       local path = node:get_id()
        #       vim.api.nvim_input(": " .. path .. "<Home>")
        #     end
        #   '';
        #   imagePreview = ''
        #     function(state)
        #       local node = state.tree:get_node()
        #       if node.type == "file" then
        #         require("image_preview").PreviewImage(node.path)
        #       end
        #     end
        #   '';
        # };
      };
    };
  };
}
