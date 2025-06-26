{
  description = "Home Manager configuration";

  inputs.home-manager.url = "github:nix-community/home-manager";

  inputs.nixvim.url = "github:immortalrover/nixvim";
  inputs.tmux.url = "github:immortalrover/tmux";

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      nixvim,
      tmux,
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
            neovim = nixvim.packages.${pkgs.system}.default;
            tmux = tmux.packages.${pkgs.system}.default;
          })
        ];
      };
    in
    {
      homeConfigurations."rover" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix

          {
            home.packages = [
            ];
          }
        ];
      };
    };
}
