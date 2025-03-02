{ lib, config, ... }:
let
  inherit (lib) mkIf;
  isEnabled = config.modules.mini.ai_textobjs.enable;
in
{
  plugins.mini.modules.ai = mkIf isEnabled {
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
}
