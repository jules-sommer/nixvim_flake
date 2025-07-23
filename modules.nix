{ nixvim }:
{
  nixosModules.default =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      imports = [ inputs.nixvim.nixosModules.nixvim ];
      programs.nixvim = import ./nixvim.nix { inherit pkgs lib config; };
    };

  homeManagerModules.default =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      imports = [ inputs.nixvim.homeManagerModules.nixvim ];
      programs.nixvim = import ./nixvim.nix { inherit pkgs lib config; };
    };
}
