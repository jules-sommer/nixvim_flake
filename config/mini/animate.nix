{
  lib,
  helpers,
  config,
  ...
}:
let
  inherit (lib) mkIf;
  isEnabled = config.modules.mini.animate.enable;
in
{
  plugins.mini.modules.animate =
    mkIf isEnabled {
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
              if SCROLL_STATE.mouse_scrolled then
                SCROLL_STATE.mouse_scrolled = false
                return false
              end
              return total_scroll > 5
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
}
