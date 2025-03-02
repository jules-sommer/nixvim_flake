{
  theme,
  helpers,
  lib,
  config,
  ...
}:
let
  args = {
    inherit helpers lib config;
  };

  mini_modules = {
    completion = import ./completion.nix args;
  };
in
with lib;
{
  imports = [
    ./base16.nix
    ./completion.nix
    ./ai_textobjs.nix
    ./animate.nix
  ];

  options.modules.mini = {
    ai_textobjs = mkEnableOpt "Enable mini.ai text objects extensions module.";
    base16 = mkEnableOpt "Enable mini.base16 colourscheme module.";
    completion = mkEnableOpt "Enable mini.completion module, similar functionality to `cmp`.";
    animate = mkEnableOpt "Enable mini.animate module, adds animations for scrolling and such.";
  };

  config = {
    plugins.mini = {
      enable = true;
      mockDevIcons = true;
      modules = lib.mkMerge [
        {
          pick = { };
          pairs = {
            mappings = {
              "(" = {
                action = "open";
                pair = "()";
                neigh_pattern = "[^\\].";
              };
              "''" = {
                action = "open";
                pair = "''\n''";
                neigh_pattern = "[^\\].";
              };
              "[" = {
                action = "open";
                pair = "[]";
                neigh_pattern = "[^\\].";
              };
              "{" = {
                action = "open";
                pair = "{}";
                neigh_pattern = "[^\\].";
              };
              ")" = {
                action = "close";
                pair = "()";
                neigh_pattern = "[^\\].";
              };
              "]" = {
                action = "close";
                pair = "[]";
                neigh_pattern = "[^\\].";
              };
              "}" = {
                action = "close";
                pair = "{}";
                neigh_pattern = "[^\\].";
              };
              "\"" = {
                action = "closeopen";
                pair = "\"\"";
                neigh_pattern = "[^%a\\].";
                register = {
                  cr = false;
                };
              };
              "`" = {
                action = "closeopen";
                pair = "``";
                neigh_pattern = "[^\\].";
                register = {
                  cr = false;
                };
              };
            };
          };
          snippets = { };
          basics = { };
          indentscope = { };
          misc = { };
          move = { };
          sessions = { };
          # hues = {
          #   background = "#000000";
          #   foreground = "#ffffff";
          #   accent = "purple";
          #   n_hues = 8;
          # };
          hipatterns = { };
          git = { };
          extra = { };
          fuzzy = { };
          diff = { };
          visits = { };
          test = { };
          splitjoin = { };
          ai = {
            n_lines = 50;
            search_method = "cover_or_next";
            mappings = {
              around = "a";
              inside = "i";

              around_next = "an";
              inside_next = "in";
              around_last = "al";
              inside_last = "il";

              goto_left = "g[";
              goto_right = "g]";
            };
          };
          diff = {
            view = {
              style = "sign";
            };
          };
          icons = { }; # Icon provider 	README 	Help file
          indentscope = {
            draw = {
              delay = 75;
              priority = 2;
            };
            mappings = {
              object_scope = "ii";
              object_scope_with_border = "ai";

              goto_top = "[i";
              goto_bottom = "]i";
            };

            options = {
              border = "both";
              indent_at_cursor = true;

              try_as_border = false;
            };
            symbol = "│";
          };
          surround = {
            mappings = {
              add = "gsa";
              delete = "gsd";
              find = "gsf";
              find_left = "gsF";
              highlight = "gsh";
              replace = "gsr";
              update_n_lines = "gsn";
            };
          };
          tabline = {
            show_icons = true;
          };
          comment = { };
        }
      ];
    };
  };
}
