{
  config,
  lib,
  helpers,
  ...
}:
let
  inherit (lib) mkIf enabled;
  cfg = config.plugins.yanky;
in
{
  config = mkIf cfg.enable {
    keymaps = [
      {
        mode = [
          "n"
          "x"
        ];
        key = "p";
        action = "<Plug>(YankyPutAfter)";
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "P";
        action = "<Plug>(YankyPutBefore)";
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "gp";
        action = "<Plug>(YankyGPutAfter)";
      }
      {
        mode = [
          "n"
          "x"
        ];
        key = "gP";
        action = "<Plug>(YankyGPutBefore)";
      }
      {
        mode = [ "n" ];
        key = "<c-p>";
        action = "<Plug>(YankyPreviousEntry)";
      }
      {
        mode = [ "n" ];
        key = "<c-n>";
        action = "<Plug>(YankyNextEntry)";
      }
    ];

    plugins.yanky = {
      enableTelescope = true;
      settings = {
        onPut = true;
        onYank = true;
        timer = 500;
        useDefaultMappings = false;
        picker = {
          telescope = {
            enable = true;
            mappings = {
              default = "mapping.put('p')";
              i = {
                "<c-g>" = "mapping.put('p')";
                "<c-k>" = "mapping.put('P')";
                "<c-r>" = "mapping.set_register(utils.get_default_register())";
                "<c-x>" = "mapping.delete()";
              };
              n = {
                P = "mapping.put('P')";
                d = "mapping.delete()";
                p = "mapping.put('p')";
                r = "mapping.set_register(utils.get_default_register())";
              };
            };
          };
        };
        preserveCursorPosition = true;
        ring = {
          # TODO: move this back to sqlite storage once sqlite.lua works
          # on neovim nightly + nixvim master
          storage = "shada";
          cancelEvent = "update";
          historyLength = 100;
          ignoreRegisters = [ "_" ];
          storagePath = helpers.mkRaw "vim.fn.stdpath('data') .. '/databases/yanky.db'";
          syncWithNumberedRegisters = true;
        };
        systemClipboard = {
          syncWithRing = true;
        };
        textobj = enabled;
      };
    };
  };
}
