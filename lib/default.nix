{ lib, ... }:
let
  inherit (lib) mkOption types;
in
rec {
  mkOpt =
    type: default: description:
    mkOption { inherit type default description; };

  mkOpt' = type: default: mkOpt type default null;

  mkBoolOpt = mkOpt types.bool;

  mkBoolOpt' = mkOpt' types.bool;

  enablePred = pred: {
    enable = pred;
  };

  enablePred' =
    pred: cfg:
    {
      enable = pred;
    }
    // cfg;

  enabled' =
    cfg:
    {
      enable = true;
    }
    // cfg;

  disabled' =
    cfg:
    {
      enable = false;
    }
    // cfg;

  enabled = {
    enable = true;
  };

  disabled = {
    enable = false;
  };
}
