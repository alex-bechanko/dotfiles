{ inputs, lib, config, pkgs, ... }: {
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

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "alex";
    homeDirectory = "/home/alex";
  };

  xdg.enable = true;

  home.packages = with pkgs; [ obsidian ];

  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Alex Bechanko";
    userEmail = "alexbechanko@gmail.com";
    extraConfig.init.defaultBranch = "main";
  };


  programs.bash = {
    enable = true;
    bashrcExtra = builtins.readFile ../config/bash/bashrc;
  };

  programs.neovim = {
    enable = true;

    viAlias      = true;
    vimAlias     = true;
    vimdiffAlias = true;

    defaultEditor = true;

    extraLuaConfig = builtins.readFile ../config/neovim/init.lua;



    plugins = [
      pkgs.vimPlugins.nvim-treesitter.withAllGrammars

      pkgs.vimPlugins.nvim-lspconfig
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.gruvbox-material
      pkgs.vimPlugins.vim-nix
    ];
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
