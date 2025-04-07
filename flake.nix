{
  description = "Home Manager configuration";

  inputs.nixvim.url = "github:dc-tec/nixvim";
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
      pkgs = import nixpkgs { inherit system; };
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
