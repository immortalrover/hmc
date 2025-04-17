{
  config,
  pkgs,
  ...
}:
let
  ghosttyPath = "${config.home.homeDirectory}/.config/home-manager/dotfiles/ghostty";
in
{
  home = {
    username = "rover";
    homeDirectory = "/home/rover";
    stateVersion = "24.11";
    packages = with pkgs; [
      neofetch
      git
      lua-language-server
      pyright
      prettierd
      nil
      nixfmt-rfc-style
      lazygit
      yarn
      obsidian
      neovim
    ];
  };

  xdg = {
    enable = true;
    configFile = {
      "ghostty" = {
        source = config.lib.file.mkOutOfStoreSymlink ghosttyPath;
        recursive = true;
      };
    };
  };

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
    eza = {
      enable = true;
      enableZshIntegration = true;
      colors = "always";
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
      git = true;
      icons = "auto";
    };
  };

  programs.home-manager.enable = true;
}
