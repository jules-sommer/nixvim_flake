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
    utils.url = "github:numtide/flake-utils";

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
      utils,
      zls,
      ...
    }@inputs:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      channels = utils.lib.eachSystem systems (
        system:
        let
          mkChannel = input: rec {
            inherit (pkgs) lib;
            pkgs = input.legacyPackages.${system};
            __input = input;
          };
        in
        {
          default = mkChannel unstable;
          master = mkChannel master;
        }
      );

      overlays = [
        neovim-nightly.overlays.default
        (_: prev: {
          inherit (zls.outputs.packages.${prev.system}) zls;
          neovim-unwrapped = prev.neovim;
        })
      ];
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      inherit systems;
      perSystem =
        { system, ... }:
        let
          pkgs = import channels.default.${system}.__input {
            inherit system overlays;
          };

          inherit (pkgs.lib) extend;

          local = {
            lib = import ./lib { inherit (pkgs) lib; };
            plugins = import ./packages { inherit pkgs lib; };
          };

          # extends nixpkgs lib with nixvim's lib overlay, and then extends the resulting
          # lib with our own local lib functions to create one unified lib to pass thru module args.
          lib = (extend nixvim.lib.overlay).extend (_: _: local.lib);

          theme = base24-themes.themes.tokyo_night_dark;
          plugins = pkgs.vimPlugins // local.plugins;

          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};

          nixvimModule = {
            inherit pkgs;
            module =
              { ... }:
              {
                imports = [
                  ./config
                ];
                nixpkgs = {
                  inherit pkgs;
                };
              };
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
          } // local.plugins;
        };
    }
    // {
      inherit channels;
    };

}
