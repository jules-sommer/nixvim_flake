{
  description = "Xeta nixvim configuration";

  inputs = {
    master.url = "github:nixos/nixpkgs/master";
    unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    zig-master = {
      url = "/home/jules/000_dev/000_nix/nix-zig-compiler";
      inputs.nixpkgs.follows = "master";
    };

    zls-master = {
      url = "/home/jules/000_dev/010_zig/010_repos/zls";
      inputs.nixpkgs.follows = "master";
    };

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
      nixvim,
      master,
      unstable,
      base24-themes,
      neovim-nightly,
      flake-parts,
      zls-master,
      zig-master,
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
          overlays = [
            neovim-nightly.overlays.default
            (_: prev: {
              inherit (zls-master.packages.${system}) zls;
              zig = zig-master.packages.${system}.zigPrebuilt;
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

          pkgs = import master {
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
                zls-master
                zig-master
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
            inherit pkgs channels;
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
              ;
          };
        };
    }
    // {

    };
}
