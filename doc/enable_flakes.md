# Enable Flakes
## Step 1
Edit `~/.config/nix/nix.conf` or `/etc/nix/nix.conf`
## Step 2
Add `experimental-features = nix-command flakes`
## Step 3
Run `sudo systemctl restart nix-daemon.service`
## Step 4
Copy a `flake.nix` like this

```nix
{
  description = "Home Manager configuration";

  inputs.home-manager.url = "github:nix-community/home-manager";

  outputs =
    inputs@{ nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
      homeConfigurations."rover" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
}
```
> Please replace `rover` with your own name!!!
## Step 5
Run `home-manager switch --flake ~/.config/home-manager/`
(Your own home manager config path)
