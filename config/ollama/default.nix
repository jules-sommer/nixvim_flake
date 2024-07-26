{ pkgs
, config
, lib
, ...
}:
let
  inherit (lib) mkEnableOption mkIf types;
  cfg = config.plugins.ollama;
in
{
  config = mkIf cfg.enable {
    plugins.ollama = {
      action = "display_replace";
      model = "llama3";
      serve = {
        onStart = false;
      };
    };
  };
}
