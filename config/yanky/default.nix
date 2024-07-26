{ config, lib, theme, ... }:
let
  inherit (lib) mkEnableOption mkIf enabled;
  cfg = config.plugins.yanky;
in
{
  config = mkIf cfg.enable {
    keymaps = [ ];
    plugins.yanky = {
      enableTelescope = true;
      settings = {
        onPut = true;
        onYank = true;
        timer = 500;
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
          cancelEvent = "update";
          historyLength = 100;
          ignoreRegisters = [ "_" ];
          storage = "sqlite";
          storagePath = ''
            {__raw = "vim.fn.stdpath('data') .. '/databases/yanky.db'";}
          '';
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
