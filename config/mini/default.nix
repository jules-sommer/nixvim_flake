{
  theme,
  helpers,
  lib,
  config,
  ...
}:
with lib;
{
  config = {
    extraConfigLua = ''
      -- don't use animate when scrolling with the mouse
      local mouse_scrolled = false
      for _, scroll in ipairs({ "Up", "Down" }) do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set({ "", "i" }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end
    '';
    plugins.mini = {
      enable = true;
      modules = {
        ai = {
          n_lines = 50;
          search_method = "cover_or_next";
        };
        surround = { };
        base16 = {
          palette = with theme.colors; {
            inherit
              base00
              base01
              base02
              base03
              base04
              base05
              base06
              base07
              base08
              base09
              base0A
              base0B
              base0C
              base0D
              base0E
              base0F
              ;
          };
        };
        # basics = { };
        # bracketed = { };
        # clue = { };
        # colors = { };
        # comment = {
        #   mappings = {
        #     comment = "<leader>/";
        #     comment_line = "<leader>/";
        #     comment_visual = "<leader>/";
        #     textobject = "<leader>/";
        #   };
        # };
        diff = {
          view = {
            style = "sign";
          };
        };
        # doc = { };
        # extra = { };
        # files = { };
        # fuzzy = { };
        # cursorword = { };
        # align = { };
        animate =
          {
            cursor = {
              enable = true;
              timing = helpers.mkRaw ''
                require("mini.animate").gen_timing.cubic({ easing = "in-out", duration = 33, unit = 'total' })
              '';
            };
            scroll = {
              enable = true;
              timing = helpers.mkRaw ''
                require("mini.animate").gen_timing.cubic({
                  easing = "in-out",
                  duration = 150,
                  unit = "total"
                })
              '';
              subscroll = helpers.mkRaw ''
                animate.gen_subscroll.equal({
                  predicate = function(total_scroll)
                    if mouse_scrolled then
                      mouse_scrolled = false
                      return false
                    end
                    return total_scroll > 1
                  end,
                }),
              '';
            };
            resize = {
              enable = true;
              timing = helpers.mkRaw ''
                require("mini.animate").gen_timing.linear({ duration = 50, unit = "total" })
              '';
            };
          }
          // (mkIf (!config.plugins.cmp.enable) {
            completion = {
              window = {
                info = {
                  height = 25;
                  width = 80;
                  border = "rounded";
                  zindex = 300;
                  style = "minimal";
                };
                signature = {
                  height = 25;
                  width = 80;
                  border = "rounded";
                  zindex = 300;
                  style = "minimal";
                };
              };
              set_vim_settings = true;
            };
          });
        # indentscope = { };
        # git = { };
        # bufremove = { }; # Remove buffer from buffer list 	README 	Help file
        # hipatterns = { }; # Highlight patterns in text 	README 	Help file
        icons = { }; # Icon provider 	README 	Help file
        indentscope = {
          # Draw options
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
        # map = { }; # Window with buffer text overview 	README 	Help file
        # misc = { }; # Miscellaneous functions 	README 	Help file
        # move = { }; # Move any selection in any direction 	README 	Help file
        # operators = { }; # Text edit operators 	README 	Help file
        # pairs = { }; # Autopairs 	README 	Help file
        # pick = { }; # Pick anything 	README 	Help file
        # sessions = { }; # Session management 	README 	Help file
        # splitjoin = { }; # Split and join arguments 	README 	Help file
        # statusline = { }; # Statusline 	README 	Help file
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
        }; # Tabline 	README 	Help file
        # test = { }; # Test Neovim plugins 	README 	Help file
        # trailspace = { }; # Trailspace (highlight and remove) 	README 	Help file
        # visits = { };
      };
    };
  };
}
