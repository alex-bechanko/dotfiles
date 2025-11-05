{
  inputs,
  lib,
  config,
  pkgs,
  username,
  hostname,
  ...
}:
{
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home.packages = with pkgs; [
    elmPackages.elm-language-server
    gopls
    nixd
    nixfmt
    gcc
    quarto
    rustup
    sumneko-lua-language-server
    dhall-lsp-server
    luajit
    glas
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;
  };

  xdg.configFile.nvim = {
    source = ../../config/nvim;
    recursive = true;
  };
}
