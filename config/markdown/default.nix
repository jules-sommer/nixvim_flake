{ lib, config, ... }:
let
  inherit (lib) mkEnableOpt mkIf;
  cfg = config.modules.markdown;
in
{
  options.modules.markdown = mkEnableOpt "Enable markdown rendering via `render-markdown` plugin";

  config = mkIf cfg.enable {
    plugins.render-markdown = {
      enable = true;
      settings = {
        debounce = 100;
        max_file_size = 20.0;
        injections = {
          gitcommit = {
            enabled = true;
            query = ''
              ((message) @injection.content
                  (#set! injection.combined)
                  (#set! injection.include-children)
                  (#set! injection.language "markdown"))
            '';
          };
        };
      };
    };
  };
}
