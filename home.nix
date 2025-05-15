{
  config,
  pkgs,
  ...
}:
let
  ghosttyPath = "${config.home.homeDirectory}/.config/home-manager/dotfiles/ghostty";
  tex = (
    pkgs.texlive.combine {
      inherit (pkgs.texlive)
        scheme-basic
        ctex
        float
        caption
        unicode-math
        mathtools
        extarrows
        ragged2e
        booktabs
        physics
        supertabular
        multirow
        ntheorem
        gbt7714
        pgfplots
        listings
        shipunov
        seqsplit
        siunitx
        threeparttable
        xltabular
        ltablex
        makecell
        diagbox
        pict2e
        algorithm2e
        ifoddpage
        relsize
        tocloft
        footmisc
        bigfoot
        psnfss
        times
        ;
    }
  );
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
      tmux
      zathura
      discord
      tex

      # ffmpeg-full
      # go-musicfox
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
