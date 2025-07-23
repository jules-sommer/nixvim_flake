{
  description = "Jules' nixvim config :3";

  outputs =
    {
      self,
      nixvim,
      nixpkgs,
      flake-parts,
      neovim-nightly,
      zls-overlay,
      flake-utils,
      base24-themes,
      ...
    }@inputs:
    let
      lib =
        (nixpkgs.lib.extend (_: prev: { __extended = true; } // prev // self.lib)).extend
          nixvim.lib.overlay;

      overlays = [
        neovim-nightly.overlays.default
        zls-overlay.overlays.default
      ];

      theme = base24-themes.themes.tokyo_night_dark;
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
          pkgs = import nixpkgs { inherit system overlays; };
          plugins = import ./packages/default.nix { inherit pkgs lib; } // pkgs.vimPlugins;
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            inherit system;
            module = import ./config;
            extraSpecialArgs = {
              inherit
                lib
                pkgs
                plugins
                theme
                inputs
                system
                ;
            };
          };
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
        in
        {
          checks = {
            default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          };

          packages = {
            default = nvim;
          };
        };
      flake = {
        lib = import ./lib { inherit (nixpkgs) lib; };
        plugins = flake-utils.lib.eachDefaultSystem (
          system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
          import ./packages/default.nix { inherit pkgs lib; } // pkgs.vimPlugins
        );
      };
    };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
    zls-overlay.url = "github:jules-sommer/zls-overlay";
    flake-utils.url = "github:numtide/flake-utils";
    base24-themes.url = "github:jules-sommer/nix_b24_themes";
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
