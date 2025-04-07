{
  config,
  pkgs,
  inputs,
  ...
}:
let
  nvimPath = "${config.home.homeDirectory}/.config/home-manager/nvim";
  zshPath = "${config.home.homeDirectory}/.config/home-manager/dotfiles/.zshrc";
  ghosttyPath = "${config.home.homeDirectory}/.config/home-manager/dotfiles/ghostty";
in
{
  home.username = "rover";
  home.homeDirectory = "/home/rover";
  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    neofetch
    git
    lua-language-server
    pyright
    prettierd
    nil
    nixfmt-rfc-style
    lazygit
    inputs.nixvim.packages.x86_64-linux.default
  ];
  home.file = {
    ".zshrc".source = config.lib.file.mkOutOfStoreSymlink zshPath;
  };
  xdg = {
    enable = true;
    configFile = {
      "nvim" = {
        enable = false;
        source = config.lib.file.mkOutOfStoreSymlink nvimPath;
        recursive = true;
      };
      "ghostty" = {
        source = config.lib.file.mkOutOfStoreSymlink ghosttyPath;
        recursive = true;
      };
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/rover/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableVteIntegration = true;
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      theme = "kardan";
      plugins = [
        "vi-mode"
      ];
    };
  };
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  # programs.neovim = {
  #   enable = true;
  #   defaultEditor = true;
  #   vimAlias = true;
  #   viAlias = true;
  # };
  # programs.nixvim = {
  #   enable = true;
  # };
  programs.home-manager.enable = true;
}
