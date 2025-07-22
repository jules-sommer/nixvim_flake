{
  config,
  lib,
  helpers,
  ...
}:
with lib;
let
  cfg = config.lsp.rustaceanvim;
in
{
  options.lsp.rustaceanvim = {
    enable = mkEnableOption "Enable rustaceanvim configuration.";
  };

  config = mkIf cfg.enable {
    plugins.rustaceanvim = enabled;
  };
}
