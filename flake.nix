{
  description = "Xeta nixvim configuration";

  inputs = {
    master.url = "github:nixos/nixpkgs/master";
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    zls.url = "github:zigtools/zls";

    tokyonight-nvim = {
      url = "/home/jules/000_dev/030_lua/tokyo-neon-night";
      flake = false;
    };

    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";

    base24-themes.url = "github:jules-sommer/nix_b24_themes";
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "master";
    };
  };

  outputs =
    {
      self,
      nixvim,
      master,
      unstable,
      base24-themes,
      neovim-nightly,
      flake-parts,
      zls,
      ...
    }@inputs:
    let
      inherit (inputs.unstable.legacyPackages.${"x86_64-linux"}.lib) composeManyExtensions;
    in
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
          overlays = [
            neovim-nightly.overlays.default
            (_: prev: {
              inherit (zls.outputs.packages.${prev.system}) zls;
              neovim-unwrapped = prev.neovim;
            })
          ];

          channels =
            let
              mkChannel = input: rec {
                inherit (pkgs) lib;
                pkgs = import input {
                  inherit
                    system
                    overlays
                    ;

                };
              };
            in
            {
              unstable = mkChannel unstable;
              master = mkChannel master;
            };

          pkgs = import unstable {
            inherit system overlays;
          };

          # Merges the local library functions with that of the nixvimLib extendedLib (a version of nixpkgs lib with nixvim lib helpers merged in)
          lib = nixvimLib.helpers.extendedLib // (import ./lib { inherit (pkgs) lib; });

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
                channels
                ;
            };
          };
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
        in
        assert builtins.isAttrs lib && lib ? enabled && lib ? disabled && lib ? nixvim;
        {
          _module.args = {
            inherit pkgs channels plugins;
          };

          checks = {
            # Run `nix flake check .` to verify that your config is not broken
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          };

          packages = {
            # Lets you run `nix run .` to start nixvim
            default = nvim;
            inherit nixvimLib;
            inherit (local_plugins)
              treesitter-nu
              vim-smartword
              satellite-nvim
              noice
              oil-nvim
              ;
          };
        };

      flake = {
        overlays = {
          default = composeManyExtensions [
            neovim-nightly.overlays.default
            (_: prev: {
              inherit (zls.outputs.packages.${prev.system}) zls;
              neovim-unwrapped = prev.neovim;
            })
          ];
        };
      };
    }
    // {
      nixosModules.default =
        {
          pkgs,
          ...
        }:
        {
          config = {
            environment.systemPackages = [
              self.packages.${pkgs.system}.default
            ];
          };
        };
    };
}
