{
  description = "Home Manager configuration";

  inputs.nixvim.url = "github:immortalrover/nixvim";
  inputs.home-manager.url = "github:nix-community/home-manager";

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      nixvim,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
        overlays = [
          (final: prev: {
            neovim = inputs.nixvim.packages.${pkgs.system}.default;
          })
        ];
      };
    in
    {
      homeConfigurations."rover" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
        ];
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
}
