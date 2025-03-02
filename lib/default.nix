{ lib, ... }:
let
  inherit (lib) mkOption types;
in
rec {
  ## Create a NixOS module option, with an optional description.
  ##
  ## Usage without description:
  ## ```nix
  ## lib.mkOpt nixpkgs.lib.types.str "My default"
  ## ```
  ##
  ## Usage with description:
  ## ```nix
  ## lib.mkOpt nixpkgs.lib.types.str "My default" "Description of my option."
  ## ```
  ##
  #@ Type -> Any -> Optional String -> mkOption
  mkOpt =
    type: default: description:
    mkOption { inherit type default description; };

  mkEnableOpt = desc: {
    enable = lib.mkEnableOption desc;
  };

  # Enables a NixOS module option if the provided predicate evaluates to true.
  # Also takes an attrset for additional option configuration.
  #
  # Example:
  # ```nix
  # byteCompileLua = enablePred helpers.enableExceptInTests;
  # ````
  # Results in the attrset, bool depends on the pred fn:
  # ```nix
  # byteCompileLua = {
  #   enable = bool,
  # }
  # ````
  enablePred = fn: {
    enable = fn;
  };

  # Enables a NixOS module option if the provided predicate evaluates to true.
  # Also takes an attrset for additional option configuration.
  #
  # Example:
  # ```nix
  # byteCompileLua = enablePred' helpers.enableExceptInTests {
  #   nvimRuntime = true;
  #   plugins = true;
  # };
  # ````
  enablePred' =
    fn: cfg:
    {
      enable = fn;
    }
    // cfg;

  ## Create a NixOS module option without a description.
  ##
  ## ```nix
  ## lib.mkOpt' nixpkgs.lib.types.str "My default"
  ## ```
  ##
  #@ Type -> Any -> String
  mkOpt' = type: default: mkOpt type default null;

  ## Create a boolean NixOS module option.
  ##
  ## ```nix
  ## lib.mkBoolOpt true "Description of my option."
  ## ```
  ##
  #@ Type -> Any -> String
  mkBoolOpt = mkOpt types.bool;

  ## Create a boolean NixOS module option without a description.
  ##
  ## ```nix
  ## lib.mkBoolOpt true
  ## ```
  ##
  #@ Type -> Any -> String
  mkBoolOpt' = mkOpt' types.bool;

  enabled = {
    enable = true;
  };

  enabled' =
    cfg:
    {
      enable = true;
    }
    // cfg;

  disabled = {
    enable = false;
  };
}
