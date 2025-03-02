{ lib, config, ... }:
let
  inherit (lib) mkIf;
  isEnabled = config.modules.mini.base16.enable;
in
{
  plugins.mini.modules.base16 = mkIf isEnabled {
    palette = {
      base00 = "#0d0717"; # base (deeper purple-black)
      base01 = "#130b24"; # mantle (slightly lighter purple-black)
      base02 = "#261445"; # surface0 (deep purple)
      base03 = "#332561"; # surface1 (rich purple)
      base04 = "#413979"; # surface2 (bright purple-grey)
      base05 = "#a862f9"; # text (warm lavender)
      base06 = "#ffcbd8"; # rosewater (warm pink)
      base07 = "#cd92f2"; # lavender
      base08 = "#e93a8c"; # red
      base09 = "#ffc19e"; # peach
      base0A = "#f5e37a"; # yellow
      base0B = "#92e6aa"; # green (shifted slightly warmer)
      base0C = "#7cd5d3"; # teal (more muted, slightly warmer)
      base0D = "#8294f9"; # blue (shifted toward purple)
      base0E = "#c678dd"; # mauve (deeper, more saturated)
      base0F = "#f7aec5"; # flamingo (warmer pink)
      base10 = "#130b24"; # mantle
      base11 = "#0a0412"; # crust (deepest purple-black)
      base12 = "#e45c98"; # maroon (rich pink)
      base13 = "#ffcbd8"; # rosewater
      base14 = "#92e6aa"; # green
      base15 = "#86cde4"; # sky (warmer cyan)
      base16 = "#7ba2e8"; # sapphire (warmer blue)
      base17 = "#f295d4"; # pink (rich magenta-pink)
    };
  };
}

# 12:19:40 PM msg_show.lua_print   print(vim.inspect(require('mini.hues').make_palette({ num_hues = 8, saturation = 'high', background = '#e93a8c', foreground = '#0d0717', accent = 'purple' }))) {
#   accent = "#440044",
#   accent_bg = "#bd62ba",
#   azure = "#004d72",
#   azure_bg = "#0097da",
#   bg = "#e93a8c",
#   bg_edge = "#ff6ead",
#   bg_edge2 = "#ff95c0",
#   bg_mid = "#ce1676",
#   bg_mid2 = "#b20063",
#   blue = "#190051",
#   blue_bg = "#807ae7",
#   cyan = "#007271",
#   cyan_bg = "#00b6b4",
#   fg = "#0d0717",
#   fg_edge = "#070310",
#   fg_edge2 = "#020007",
#   fg_mid = "#231d2f",
#   fg_mid2 = "#383145",
#   green = "#00511d",
#   green_bg = "#2fa44f",
#   orange = "#6b3700",
#   orange_bg = "#ce7000",
#   purple = "#440044",
#   purple_bg = "#bd62ba",
#   red = "#550019",
#   red_bg = "#d95a6d",
#   yellow = "#615900",
#   yellow_bg = "#a59800"
# }
