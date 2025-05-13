{
  description = "Home Manager configuration";

  inputs.nixvim.url = "github:immortalrover/nixvim";
  inputs.home-manager.url = "github:nix-community/home-manager";
  inputs.go-musicfox.url = "github:go-musicfox/go-musicfox";
  inputs.nix-gl-host.url = "github:numtide/nix-gl-host";

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      nixvim,
      go-musicfox,
      nix-gl-host,
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
          go-musicfox.overlays.default
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

          {
            home.packages = [
              nix-gl-host.packages.${system}.default
            ];
          }
        ];
      };
    };
}
