{
  description = "Xeta nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";

    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";

    base24-themes.url = "github:jules-sommer/nix_b24_themes";
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixvim,
      nixpkgs,
      base24-themes,
      neovim-nightly,
      flake-parts,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      perSystem =
        { system, ... }:
        let
          pkgs = import inputs.nixpkgs {
            inherit system;
            overlays = [
              neovim-nightly.overlays.default
              (final: prev: { neovim-unwrapped = prev.neovim; })
            ];
          };

          lib =
            import ./lib { inherit (pkgs) lib; }
            // pkgs.lib
            // {
              nixvim =
                nixvimLib
                // pkgs.lib
                # TODO: this is a hack because we're tracking the master branch and it
                # seems like they're migrating the location of these helpers as per this
                # [commit](https://github.com/nix-community/nixvim/commit/96d0a2e390128be2ea19b714d4215326abfadf83)
                # and others. Remove this once all plugins build again without this shim.
                // nixvimLib.helpers;
            };

          local_plugins = import ./packages/default.nix { inherit pkgs lib; };

          theme = base24-themes.themes.tokyo_night_dark;
          plugins = pkgs.vimPlugins // local_plugins;

          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            inherit pkgs;
            module = import ./config;
            extraSpecialArgs = {
              inherit
                lib
                pkgs
                theme
                plugins
                ;
            };
          };
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
        in
        assert builtins.isAttrs lib && lib ? enabled && lib ? disabled && lib ? nixvim;
        {
          _module.args = {
            inherit pkgs;
          };

          checks = {
            # Run `nix flake check .` to verify that your config is not broken
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          };

          packages = {
            # Lets you run `nix run .` to start nixvim
            default = nvim;
            inherit (local_plugins)
              supermaven-nvim
              treesitter-nu
              vim-smartword
              satellite-nvim
              ;
          };
        };
    };
}
